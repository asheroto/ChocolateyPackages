$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.7"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "469CACB82B4558ABAC90D48B7FC040B1FDD4E835F4A875BADED6596BA922E7FC"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs