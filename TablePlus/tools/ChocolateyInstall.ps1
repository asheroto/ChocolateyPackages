$ErrorActionPreference  = 'Stop'
$packageName    = 'TablePlus'
$softwareName   = 'TablePlus'
$url            = 'https://download.tableplus.com/windows/5.3.8/TablePlusSetup.exe'
$checksum       = '58C009BED6C64BE0EE088D7D96B491E666DA090ACDC2EB710E1B87FE0656F3CB'
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