# URL: http://www2.adminarsenal.com/download-pdqinventory
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'ebf79ee948a375a833cdf37bb867c4943a7ad8eb41d575a8b163ba7f3af03a4e'		
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Inventory_19.3.48.0.exe"

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
