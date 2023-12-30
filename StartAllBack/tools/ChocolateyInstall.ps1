$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.3"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "8674C9D138ED9883953F5190D83E2ADD9C26F8D15CA8711D5BB79B39098F85BD"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs