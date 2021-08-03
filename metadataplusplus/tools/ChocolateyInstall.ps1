$ErrorActionPreference = 'Stop'
$packageName    = 'metadataplusplus'
$softwareName   = 'Metadata++*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'f999cb7c7935f4e9e4b6f4b1420dcebaaef242e29f0ce1c2f2bef569273eca67'		
$silentArgs     = '/verysilent'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\metadata++-2-00-4.exe"

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
