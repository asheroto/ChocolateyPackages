$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Version        = "3.6.13"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${VERSION}_setup.exe"
    Checksum       = "C31DE0B203CD9A9EE737E27225FBAC96B580C34664679D64DF66D6F5187FCA34"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs