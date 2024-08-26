$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Inventory*'
    packageName    = 'pdq-inventory'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Inventory_Setup.exe"
    checksum       = '2831F2B0211771742479F19D26AAA8A69FB671109F30EE939DEFB6EB2873B7C5'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs