$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Deploy*'
    packageName    = 'pdq-deploy'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Deploy_Setup.exe"
    checksum       = '6A975B16BD2BB9B1B13A49478BDA9483E42627FA6E0E6684AACBC41085A45BDC'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs