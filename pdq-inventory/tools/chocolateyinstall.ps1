$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Inventory*'
    packageName    = 'pdq-inventory'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Inventory_Setup.exe"
    checksum       = '8EAA79A61808D98E12FE906C9CA58519DF2018BD7BBED6A87AB89D5A6565517D'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs