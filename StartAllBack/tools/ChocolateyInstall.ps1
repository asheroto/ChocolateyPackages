$ErrorActionPreference = "Stop"

# Chocolatey package parameters
$packageName    = "StartAllBack"
$softwareName   = "StartAllBack"
$version        = $env:ChocolateyPackageVersion
$url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_$($version)_setup.exe"
$checksum       = "9CF8A3E0E29E955DBED011E8ABE9DE5B6F221DB9B00D71B66B87287E83B50806"
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