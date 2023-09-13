# URL: http://www2.adminarsenal.com/download-pdqinventory
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '81CE443352E94C09E08584522AC1F8F34A3FFFC7058D49A896BA2B98E433C68B'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Inventory_19.3.446.0.exe"

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