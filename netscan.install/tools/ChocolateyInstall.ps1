$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "netscan.install"
    fileType       = "exe"
    url            = "https://www.softperfect.com/download/freeware/netscan_setup.exe"
    checksum       = "FD0F1A63D561E6FCDAA4A19AFE4429346D27A8AA3C54326C9CF0B6DF91DA7BCC"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
    validExitCodes = @(0)
    softwareName   = "SoftPerfect Network Scanner*"
}

# End process
Get-Process netscan -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs