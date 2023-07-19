$ErrorActionPreference = "Stop"

$packageName    = "clickup-official"
$softwareName   = "ClickUp*"
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = "9051FC3CED88AFB143D9C56EF016D4659774DA9B812DFF49C44D0E020FE9CC1F"
$silentArgs     = "/silent"
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\ClickUp Setup 3.3.22-x64.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = "exe"
  file          = $fileLocation
  checksum      = $checksum
  checksumType  = "sha256"
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyInstallPackage @packageArgs