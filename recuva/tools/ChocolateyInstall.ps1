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
    Version        = "1.53.2096"  # Set the correct version number
    Url            = "https://download.ccleaner.com/rcsetup153.exe"  # Set the correct download URL
    Checksum       = "B3DF198D64BA6F401611F56743BD344C1B02915F9E5D571D271EF8557FEAF56C"  # Replace with the actual checksum for the downloaded file
    ChecksumType   = "sha256"  # Use the appropriate checksum type
    SilentArgs     = "/S $locale"  # Set the silent installation arguments
    ValidExitCodes = @(0)
}

# PreventChromeInstall.ps1 adds a registry entry to block Google Chrome installation via Piriform products.
Write-Host "Adding registry keys to prevent Google Chrome and Toolbar offers with Piriform products." -ForegroundColor DarkMagenta
& "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\PreventChromeInstall.ps1"

# Install Chocolatey package
Install-ChocolateyPackage @packageArgs