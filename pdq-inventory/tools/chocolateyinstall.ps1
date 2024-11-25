$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Inventory*'
    packageName    = 'pdq-inventory'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Inventory_Setup.exe"
    checksum       = '65EB35425BC63FCEE626D7DEE028BF651C9DB65C1B328175FFD5E0176BB0734E'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs