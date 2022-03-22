# Installation Note:
# If you want to confirm the installation of the drivers, you can append the following to the silent args:
# -l C:\log.txt
# Then look at C:\log.txt to confirm the installation.

$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$softwareName   = 'intel-proset-drivers' 
$url            = "https://downloadmirror.intel.com/715194/WiFi-22.110.1-Driver64-Win10-Win11.exe"
$checksum       = '8656D874A21A66A42DC70BA5D90B438FBD8A36073F7A82AFE6A2F470E52C8F2C'
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