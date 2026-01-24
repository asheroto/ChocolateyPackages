$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Deploy*'
    packageName    = 'pdq-deploy'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Deploy_Setup.exe"
    checksum       = '31D13487330B237A76B5A35CF6780B3D094422D07C14560B8D709C6B456B5CF0'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs