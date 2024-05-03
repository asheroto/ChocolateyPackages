$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.9"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "5040BB8ED046C5F9E3880458E0D70C0FB99BC7F1663F43870744C2C841B8BB2E"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs