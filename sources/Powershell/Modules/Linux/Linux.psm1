﻿function grep
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true,Position=0)][Alias("e")]$regexp, [Parameter()][Alias("v")][switch]$NotMatch, [Parameter()][ValidateSet("auto")]$Color = $null, [Parameter()][switch]$PassThru, [Parameter(ValueFromPipeline = $true)]$PSItem)
    process{
        if($_ -ne $null)
        {
            $asstring = $_.ToString()

            if($asstring -eq $_.GetType().FullName){
                $asstring = $_ | ConvertTo-Json -Depth 5
            }
            elseif($_ -is [PSCustomObject]){
                $asstring = $_ | ConvertTo-Json -Depth 5
            }
            elseif($_ -is [PSObject]){
                $asstring = $_ | ConvertTo-Json -Depth 5
            }

            if($Color -eq "auto"){
                $return = $false
                $asstring -split "`n" | Select-String -Pattern $regexp -NotMatch:$NotMatch | % {
                    $currentPos = 0
                    $line = $_.Line
                    $_.Matches | % {
                        Write-Host $line.Substring($currentPos, $_.Index).ToString() -NoNewline
                        Write-Host $line.Substring($_.Index,$_.Length).ToString() -ForegroundColor Red -NoNewline
                        $currentPos = $_.Index+$_.Length
                    } 
                    Write-Host $line.Substring($currentPos, $line.Length - $currentPos)
                    $return = $true
                }

                if($PassThru -and $return) {$_}
            }
            else{
                $return = $false
                $asString -split "`n" | Select-String -Pattern $regexp -NotMatch:$NotMatch | % {$return = $true}
                if($return){$_}
            }
        }      
    }
}

function cut
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true,Position=0)][Alias("d")]$Delimiter, [Parameter()][Alias("f")]$Index, [Parameter(ValueFromPipeline = $true)]$PSItem)
    process{
        $PSItem | % {$_.Split($Delimiter)[$Index]}
    }
}

function pwd
{
    (gl).Path
}

Remove-Item alias:/pwd -EA SilentlyContinue

function touch
{
    [CmdletBinding()]
    param([Parameter(Position=0)]$Path)
    $item = Get-Item $Path -EA SilentlyContinue
    if($item -eq $null)
    {
        New-Item $Path
    }
    else {
        (ls $Path).LastWriteTime = Get-Date
    }
}

function head
{
    [CmdletBinding()]
    param([Parameter(Position=0)]$Count,[Parameter(ValueFromPipeline=$true)]$Item)
    begin{
        $remaining = $Count
    }
    process{
        if($Item -ne $null){
            $remaining = $remaining - 1
            if($remaining -ge 0){
                $Item
            }
        }
    }
}
