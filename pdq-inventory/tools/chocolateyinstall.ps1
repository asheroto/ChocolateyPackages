# URL: http://www2.adminarsenal.com/download-pdqinventory
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'D52477F7F6634C43C5E6B70AB27952EDD8BC8797A6924F737FE27FAC3D9C4828'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Inventory_19.3.409.0.exe"

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