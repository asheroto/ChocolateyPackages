$ErrorActionPreference  = 'Stop'
$packageName    = 'Simplifi'
$softwareName   = 'Simplifi'
$url            = 'https://github.com/asheroto/Simplifi/releases/download/0.0.3.3/Simplifi.exe'
$checksum       = '87060C7F105BBAD078BC66BD7A04F919AED480A988E740EA554B7B029F7B035E'
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