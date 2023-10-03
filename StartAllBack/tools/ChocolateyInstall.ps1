$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Version        = "3.6.12"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${VERSION}_setup.exe"
    Checksum       = "A91908491311D2326BBAC3B32A0559E1BA9E8EB3DD2B188F35793F7A5BABA6DC"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs