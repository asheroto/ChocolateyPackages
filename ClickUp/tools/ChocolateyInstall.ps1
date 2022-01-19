$ErrorActionPreference  = 'Stop'
$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.2.1/ClickUp.exe'
$checksum       = '419F76E15F5D545E72F1FDAE6D4757E2E9D6A867189F03A80926DA62E5CA2826'
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