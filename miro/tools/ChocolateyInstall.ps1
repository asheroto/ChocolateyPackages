$ErrorActionPreference = "Stop"

# Chocolatey package parameters
$packageName = "miro"
$softwareName = "Miro*"
$url = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
$url64 = "https://desktop.miro.com/platforms/win32/Miro.exe"
$checksum = "AB5975702159CD8F755B42B2A21DFA5860200F5BF4B8EFAEC2F6F797884595A0"
$checksum64 = "0D7134AF97974C04EE9330F0D7869B859C69F580786964D1B1DE599A21BF888D"
$silentArgs = "/silent"
$validExitCodes = @(0)

# Package args
$packageArgs = @{
    packageName    = $packageName
    fileType       = "exe"
    url            = $url
    url64          = $url64
    checksum       = $checksum
    checksum64     = $checksum64
    checksumType   = "sha256"
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = $softwareName
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs