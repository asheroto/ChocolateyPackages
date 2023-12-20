$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "miro"
    fileType       = "exe"
    url            = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
    url64          = "https://desktop.miro.com/platforms/win32/Miro.exe"
    checksum       = "3A06691A77CF72F46CC4A6CE61D0DA490112FBE08987B947785532B0B79758AF"
    checksum64     = "EBA16E33F75C8595BDD3A994D9934A0D993143B0462A421C461FAFEA20ECD904"
    checksumType   = "sha256"
    silentArgs     = "/silent"
    validExitCodes = @(0)
    softwareName   = "Miro*"
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs