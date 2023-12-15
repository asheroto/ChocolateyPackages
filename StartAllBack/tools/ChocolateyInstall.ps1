$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.2"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "3BE58F4C6557874F3ADBE710A78A152833B5A8FF874B2EA2BE7F54FAC96705CE"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs