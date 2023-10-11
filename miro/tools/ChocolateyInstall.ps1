$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "miro"
    fileType       = "exe"
    url            = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
    url64          = "https://desktop.miro.com/platforms/win32/Miro.exe"
    checksum       = "ACFC355405B800F8D2FBFD08A052DA4BCD076815C5CDB36CDEA599962C8A3CEC"
    checksum64     = "831987F03A1D1291E01BB57CE2CF9FB9B4ED11FBFEAB425716B5297DDE4E1EB0"
    checksumType   = "sha256"
    silentArgs     = "/silent"
    validExitCodes = @(0)
    softwareName   = "Miro*"
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs