Push-Location
cd (Split-Path $PSCommandPath -Parent)

Import-Module .\AlphaFS.dll -Force

function Remove-AlphaFSDirectory($Path, [Switch]$Recurse)
{    
    $provider = (gl).Provider
    if($provider.Name -eq 'FileSystem')
    {
        $normalized = Resolve-Path $Path
        [Alphaleonis.Win32.Filesystem.Directory]::Delete($normalized.Path, $Recurse.IsPresent, $true)
    }
    else{
        Write-Error "Not implemented"
    }
}

function Get-AlphaFSChildItem($path, [Switch]$Recurse)
{
    [Alphaleonis.Win32.Filesystem.Directory]:: EnumerateFileSystemEntryInfos($path, [Alphaleonis.Win32.Filesystem.Path]::WildcardStarMatchAll, [Alphaleonis.Win32.Filesystem.DirectoryEnumerationOptions]::Files, [Alphaleonis.Win32.Filesystem.PathFormat]::LongFullPathFullPath)
}

Pop-Location