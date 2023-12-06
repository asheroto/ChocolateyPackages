$ErrorActionPreference = "Stop"

# https://startallback.com/download.php

$Version = "3.7"

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "9DF75A0A27D3313AAE8B9957B58E43EF35F3EF248A0CD176279E4E30232298DA"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs