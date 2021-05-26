$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$url            = 'http://www2.adminarsenal.com/download-pdqinventory' 
$checksum       = '883270ae6df3355948f5556ae3400ca46011520de21a02e9fbb7a0bd35bab83a'		
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Inventory.19.3.41.0.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyPackage @packageArgs
