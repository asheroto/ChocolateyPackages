$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "miro"
    fileType       = "exe"
    url            = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
    url64          = "https://desktop.miro.com/platforms/win32/Miro.exe"
    checksum       = "D1B2B08BBB2B9593025639E537BEAB7990323BCAFCBA5BF6E54A19F143E62B40"
    checksum64     = "1859FDB908901C500E1A14E8C2719F6A9AFE91CD16B017ACC6479300B35303F8"
    checksumType   = "sha256"
    silentArgs     = "/silent"
    validExitCodes = @(0)
    softwareName   = "Miro*"
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs