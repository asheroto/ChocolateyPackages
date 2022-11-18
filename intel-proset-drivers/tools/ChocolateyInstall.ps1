# Installation Note:
# If you want to confirm the installation of the drivers, you can append the following to the silent args:
# -l C:\log.txt
# Then look at C:\log.txt to confirm the installation.

$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers'
$softwareName   = 'intel-proset-drivers'
$url            = "https://downloadmirror.intel.com/757346/WiFi-22.180.0-Driver64-Win10-Win11.exe"
$checksum       = 'FF87654A5D7F512E5C279456F21AD04693E1BC70007679FE6AC38C0F61FBEF9F'
$silentArgs     = '-silent'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs