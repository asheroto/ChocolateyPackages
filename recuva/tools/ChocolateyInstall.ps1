$ErrorActionPreference = "Stop"

# Language code
if ($Env:ChocolateyPackageParameters -match '/UseSystemLocale') {
    Write-Host "Using system locale"
    $locale = "/L=" + (Get-Culture).LCID
}

# Package args
$packageArgs = @{
    PackageName    = "recuva"
    SoftwareName   = "Recuva"
    Version        = "1.53.2096" # Leave for update.ps1
    Url            = "https://download.ccleaner.com/rcsetup153.exe" # URL does not change with Recuva
    Checksum       = "B3DF198D64BA6F401611F56743BD344C1B02915F9E5D571D271EF8557FEAF56C"  # Leave for update.ps1
    ChecksumType   = "sha256"
    SilentArgs     = "/S $locale"
    ValidExitCodes = @(0)
}

# PreventChromeInstall.ps1 adds a registry entry to block Google Chrome installation via Piriform products.
Write-Host "Adding registry keys to prevent Google Chrome and Toolbar offers with Piriform products." -ForegroundColor DarkMagenta
& "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\PreventChromeInstall.ps1"

# Install Chocolatey package
Install-ChocolateyPackage @packageArgs