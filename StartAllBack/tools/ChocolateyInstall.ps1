$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.8"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "1E9C67E480C6A4B8D1CDA4F2551D8E7043C9A1FE672AE05FE6A95BB979364EB9"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs