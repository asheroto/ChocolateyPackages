$ErrorActionPreference = 'Stop'

$packageName = 'HexEdit'
$url = 'https://github.com/strobejb/HexEdit/releases/download/v2.0.9/HexEdit_Release_x86.zip'
$url64 = 'https://github.com/strobejb/HexEdit/releases/download/v2.0.9/HexEdit_Release_x64.zip'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Use Chocolatey's built-in architecture handling
$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $drop
    url           = $url
    url64bit      = $url64
}

Install-ChocolateyZipPackage @packageArgs