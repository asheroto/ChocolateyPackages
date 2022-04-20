$ErrorActionPreference  = 'Stop'
$packageName    = 'Simplifi'
$softwareName   = 'Simplifi'
$url            = 'https://github.com/asheroto/Simplifi/releases/download/0.0.3.1/Simplifi.exe'
$checksum       = '7966A387AC707D048C75E53B5182788138525FAFB3EFF47FB1362AC2A848E014'
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