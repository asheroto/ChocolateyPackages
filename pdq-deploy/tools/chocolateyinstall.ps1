$ErrorActionPreference = 'Stop'

$packageArgs = @{
    softwareName   = 'PDQ Deploy*'
    packageName    = 'pdq-deploy'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\PDQ_Deploy_Setup.exe"
    checksum       = '775954FA28C54097814F22ACC19F418CA4A1314B3EA5F9ADA48E40CEC9360299'
    checksumType   = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs