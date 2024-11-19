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
    fileType      = 'ZIP'
    checksumType  = 'sha256'
    checksum      = 'DF9B67F4A2727F81F29EE0132344100AA25AADBF0977E55BFAC566809ABC47EC'
    url64bit      = $url64
    checksum64    = 'E83CF6A8300579EB025D73AF01BC55805AD5DC4E660352F86037626B78D34F93'
}

Install-ChocolateyZipPackage @packageArgs