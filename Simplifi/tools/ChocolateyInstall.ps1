$ErrorActionPreference  = 'Stop'
$packageName    = 'Simplifi'
$softwareName   = 'Simplifi'
$url            = 'https://github.com/asheroto/Simplifi/releases/download/0.0.3.3/Simplifi.exe'
$checksum       = '4F298559AB5B8FF4ABB6A8292E2768E3969D08A234F2A96203700B6186A6964A'
$silentArgs     = '/quiet'
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