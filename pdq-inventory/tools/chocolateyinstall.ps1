# URL: http://www2.adminarsenal.com/download-pdqinventory
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '1B8611DA8F26DD7ED9B00B1B52FA800E4B495633E8EC33AE6CD93FBF040201CC'		
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Inventory_19.3.83.0.exe"

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
