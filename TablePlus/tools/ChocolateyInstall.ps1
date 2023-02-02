$ErrorActionPreference  = 'Stop'
$packageName    = 'TablePlus'
$softwareName   = 'TablePlus'
$url            = 'https://download.tableplus.com/windows/5.2.6/TablePlusSetup.exe'
$checksum       = '79C05FB231B75204149D9D116C0F2FE736F7567EF4E6B8CFE2AC7A2737FD8BAF'
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