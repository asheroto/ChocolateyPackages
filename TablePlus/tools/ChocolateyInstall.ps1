$ErrorActionPreference  = 'Stop'
$packageName    = 'TablePlus'
$softwareName   = 'TablePlus'
$url            = 'https://download.tableplus.com/windows/5.0.1/TablePlusSetup.exe'
$checksum       = 'FE14CD0112B86F3C6A3FCD8DD4F9BE0CF4192F968EEDC711B829768553F439D7'
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0)

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