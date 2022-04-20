$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'Messages for Web'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/0.0.6.5/MessagesForWeb.exe'
$checksum       = '12729C93E0B1005B329F6BF34DDB15EDF2DA88FAC4A8DE03BD7D350628FC0427'
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