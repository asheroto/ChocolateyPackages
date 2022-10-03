$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'Messages for Web'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/v0.0.7.3/MessagesForWeb.exe'
$checksum       = '96CD8D34C6AE67B42F9E2D22AB884AA08FED550E599A0AD523D8266CBEE80741'
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