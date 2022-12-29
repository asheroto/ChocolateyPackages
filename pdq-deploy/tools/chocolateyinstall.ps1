# URL: http://www2.adminarsenal.com/download-pdqdeploy
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'CEE22FEE9503C2F34962E069D7422BD6D237996530971420DBAEFFC2818F8625'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Deploy_19.3.360.0.exe"

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