$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'MessagesForWeb'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/0.0.1.0/MessagesForWeb.exe'
$checksum       = '9E13B45B50013FAC6AA7BB25002F84FD1625056B6056CA0B6DA80B6D213C5BB6'
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