$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.5"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "763C6752BA848AF61CAB2F5C5B9CF570F11E8731E41468C530C93468060256B7"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs