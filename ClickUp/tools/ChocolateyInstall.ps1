$ErrorActionPreference  = 'Stop'
$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.4.0/ClickUp.exe'
$checksum       = '2C896A60FF99E0EFB13D2677DCE39B4A6CED7CEF16447C5A8F2C3BDECC13F9FBB61FB1EE02AAB914CC4D44A91595498C3AF32388174D4C7816FAD53BF55F7926'
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