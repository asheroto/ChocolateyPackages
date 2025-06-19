$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Inventory*'
    packageName    = 'pdq-inventory'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Inventory_Setup.exe"
    checksum       = 'B098652578F853D92F33475734084B8520027D862594FE3321589FB0A6D964F2'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs