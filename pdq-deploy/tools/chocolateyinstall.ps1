# URL: http://www2.adminarsenal.com/download-pdqdeploy
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '468E51E117C27A5D289E35BFC99499971A7B4284B318DB63C0596BE06D6518B7'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Deploy_19.3.446.0.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs