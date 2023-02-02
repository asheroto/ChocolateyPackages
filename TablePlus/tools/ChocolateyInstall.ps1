$ErrorActionPreference  = 'Stop'
$packageName    = 'TablePlus'
$softwareName   = 'TablePlus'
$url            = 'https://download.tableplus.com/windows/5.2.2/TablePlusSetup.exe'
$checksum       = '103C7B1D7549CEF7ACA252A3DDA8A02917F6E4C4791EA0FD5330C50BA48B3850'
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