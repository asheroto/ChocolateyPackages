$ErrorActionPreference  = 'Stop'
$packageName    = 'TablePlus'
$softwareName   = 'TablePlus'
$url            = 'https://download.tableplus.com/windows/5.4.3/TablePlusSetup.exe'
$checksum       = '960D197D23DA9427B7EE8FF5FB88A7D6FF3721AAAC3B23BFF2030244D839621E'
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