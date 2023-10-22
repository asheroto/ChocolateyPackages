$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Version        = "3.6.14"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${VERSION}_setup.exe"
    Checksum       = "306D8393039E5F678D2BF37B3940A2BEDB02830D6888A734BD7CE29C3B4A633A"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs