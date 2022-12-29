$ErrorActionPreference = 'Stop'
$packageName    = 'metadataplusplus'
$softwareName   = 'Metadata++*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '367A18C7270C0E7BF8FE060803EB068E7D85238D5EBB117B93669C545DF421FB'
$silentArgs     = '/verysilent'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\metadata++-2-02-3.exe"

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