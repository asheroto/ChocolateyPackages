$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Inventory*'
    packageName    = 'pdq-inventory'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Inventory_Setup.exe"
    checksum       = 'A653CFD7979DD3D7378C67FD3D8138D3DEDA766CBBDEAB6E986D716F57F2C8C9'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs