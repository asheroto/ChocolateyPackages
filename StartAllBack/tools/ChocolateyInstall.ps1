$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7.7"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "F20ADC39CE22AFC5D88A0A923878D1C61F50616EF17C1C2926541D7C0660A3E7"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs