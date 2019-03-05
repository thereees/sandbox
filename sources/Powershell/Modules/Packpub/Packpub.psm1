﻿function get($Url)
{
    Invoke-RestMethod -Method Get -Uri $Url
}

function Get-PackpubBook($isbn, [switch]$Force)
{
    $summary = get https://static.packt-cdn.com/products/$isbn/summary
    $toc = get https://static.packt-cdn.com/products/$isbn/toc
    

    if($Force)
    {
        rm $ISBN -Force -Recurse -EA SilentlyContinue
    }
    if((Test-Path $isbn) -eq $false)
    {
        mkdir $ISBN
    }
    
    pushd $ISBN
       

    if($Force)
    {
        rm .build -Force -Recurse -EA SilentlyContinue
    }

    if((Test-Path .build) -eq $false)
    {
        mkdir .build
        pushd .build

        $summary | ConvertTo-Json -Depth 10 | Out-FileUtf8NoBom "summary.json"
        wget $summary.coverImage -OutFile "cover.png"
        $authors = $summary.authors|% {
            get https://static.packt-cdn.com/authors/$_
        }
        $toc | ConvertTo-Json -Depth 10 | Out-FileUtf8NoBom "toc.json"
        ConvertTo-Json -InputObject @($authors) -Depth 10 | Out-FileUtf8NoBom "authors.json"

        $sections = $toc.chapters.sections
        $sections |% {
            Write-Progress -Activity $isbn -CurrentOperation "Chapter $($_.id)"
            
            $i = 1;
            if($_.id -match "^ch(?<N>\d+)"){
                $i = [int]::Parse($Matches['N'])
            }
            $chapter = get https://services.packtpub.com/products-v1/products/$isbn/$i/$($_.id)
            $chapter | ConvertTo-Json -Depth 10 | Out-FileUtf8NoBom "chapter_$($_.id).json"
            $fullPath = Join-Path (gl).ProviderPath "$($_.id).original"
            Write-Host $fullPath
            
            #$chapterhtml = wget $chapter.data
            #[System.IO.File]::WriteAllText($fullPath, $chapterhtml.Content, [System.Text.Encoding]::UTF8)
            wget $chapter.data -OutFile $fullPath
            Copy-Item "$($_.id).original" "$($_.id).html"
        }

        popd
    }
    else 
    {
        Write-Host "Skiping download of originals"
    }

    pushd .build

    rm *.html
    ls *.original | % {Copy-Item $_.FullName "$($_.FullName).html"}
    $count = (ls *.html | Measure-Object).Count
    $i = 0
    (cat .\*.html)|% {
        $_|
            sls '"(?<NAME>[^"]*\.jpg)"' -AllMatches|
            % {$_.Matches.Value}|
            % {$_.Trim('"')}|
            Sort -Unique
    }|% {
        Write-Progress -Activity $isbn -CurrentOperation "Resource $($_)"
        $new_ = [System.Text.RegularExpressions.Regex]::Replace($_, "^/graphics", "")
            
        $fi = [System.IO.FileInfo]::new($_)
        mkdir $fi.Directory.FullName -Force | Out-Null
        
        $url = "https://static.packt-cdn.com/products$($new_)"
        if((Test-Path $fi.FullName) -eq $false) {
            Write-Host "Downloading $($fi.FullName)"
            wget $url -OutFile $fi.FullName
        }
        else 
        {
            Write-Host "Skiping download of $url"
        }
    }

    #(ls .\*.html)|% {
        #$fullName = $_.FullName
        #$str = [System.IO.File]::ReadAllText($fullname, [System.Text.Encoding]::UTF8)
        #$str = $str.Replace("<h2","<h1").Replace("</h2","</h1")
        #$str = $str.Replace("<h3","<h2").Replace("</h3","</h2")
        #$str = $str.Replace("<h4","<h3").Replace("</h4","</h3")
        #[System.IO.File]::WriteAllText($fullName, $str, [System.Text.Encoding]::UTF8)                          
    #}

    iex "pandoc $((ls *.html|%{$_.Name}) -join ' ') -o ../$ISBN.pdf --toc --top-level-division=chapter -V documentclass=book --template=c:\github\pandoc-latex-template\eisvogel.tex --base-header-level=2 -s"

    popd
    popd

    #rm c:\graphics -Recurse -Force -EA SilentlyContinue
}

Get-PackpubBook 9781787123663
#start book.epub