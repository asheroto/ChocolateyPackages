$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'MessagesForWeb'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/0.0.5/MessagesForWeb.exe'
$checksum       = '74CA4CE4796A81A35E9363CC28C2257B3062E0BAAEA1468547F304CE2B931598'
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