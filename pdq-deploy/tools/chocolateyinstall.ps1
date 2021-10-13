# URL: http://www2.adminarsenal.com/download-pdqdeploy
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'E89963511EF3D22B51C0B51450FAC2A5433AC9C35F3F6860551B0163DCD63970'		
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Deploy_19.3.83.0.exe"

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
