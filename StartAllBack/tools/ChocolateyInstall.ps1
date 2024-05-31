$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.10"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "1BA1F1236AD8D317312B155B5D854D7E7846183171F78C084A3DBE04CD67B123"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs