$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.1"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "389A8F06DDCC22CFCB93BB79B020C84947CE90B27B09CF2A17C91729742F23BB"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs