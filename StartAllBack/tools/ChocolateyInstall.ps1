$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.6"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "CC08B5E72B9C9802D5AED41AD6B464C9FA45CA0BF6CEEEE347C931E537D1FFCC"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs