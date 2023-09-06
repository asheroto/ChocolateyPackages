$ErrorActionPreference = "Stop"

# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# WAIT
# https://muut.com/startisback#!/general:winget-silent-args

# https://startallback.com/download.php
# Chocolatey package parameters
$packageName    = "StartAllBack"
$softwareName   = "StartAllBack"
$version        = "3.6.12"
$url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_$($version)_setup.exe"
$checksum       = "A91908491311D2326BBAC3B32A0559E1BA9E8EB3DD2B188F35793F7A5BABA6DC"
$silentArgs     = "/silent"
$validExitCodes = @(0)

# Package args
$packageArgs = @{
    packageName    = $packageName
    fileType       = "exe"
    url            = $url
    checksum       = $checksum
    checksumType   = "sha256"
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = $softwareName
}

# Install
Install-ChocolateyPackage @packageArgs