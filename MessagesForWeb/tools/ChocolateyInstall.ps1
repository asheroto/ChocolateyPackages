$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'Messages for Web'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/0.0.7.1/MessagesForWeb.exe'
$checksum       = 'CDC3CD2E0B8BBD301058798382B478452256D6020341693F3DD18D66E843F44F'
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