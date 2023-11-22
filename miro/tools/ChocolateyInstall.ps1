$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "miro"
    fileType       = "exe"
    url            = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
    url64          = "https://desktop.miro.com/platforms/win32/Miro.exe"
    checksum       = "B81ED2F36AC51C470E01BE7572AADB0ED5D20D04DE8608DA00D0E145FA869F44"
    checksum64     = "57F116388ECB08B0C39F0E33445DB559295E0FACB3C12E96E584533A4E276B68"
    checksumType   = "sha256"
    silentArgs     = "/silent"
    validExitCodes = @(0)
    softwareName   = "Miro*"
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs