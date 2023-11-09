$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Version        = "3.6.16"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${VERSION}_setup.exe"
    Checksum       = "6F54D5E22A25CE2176A27F8D7784ACF60E46F43CB4EECD8E155C202A94634601"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs