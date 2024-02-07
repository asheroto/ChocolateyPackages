$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Deploy*'
    packageName    = 'pdq-deploy'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Deploy_Setup.exe"
    checksum       = '0E4AEF0FE7F5E75C5EEDE5402C2AFA2D861329EFCC76D17FA6126190683D09DC'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs