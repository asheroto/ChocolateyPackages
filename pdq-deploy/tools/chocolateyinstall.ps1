$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Deploy*'
    packageName    = 'pdq-deploy'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Deploy_Setup.exe"
    checksum       = '4D9A2EAC220501A7E4C7843060224EA03747C13FD06733CF7D48B051A732B3D0'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs