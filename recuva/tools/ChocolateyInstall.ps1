$ErrorActionPreference = "Stop"

# Language code
$LCID = (Get-Culture).LCID

# Path to PreventChromeInstall.ps1
$PreventChromeInstall = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\PreventChromeInstall.ps1"

# Package args
$packageArgs = @{
    PackageName    = "recuva"
    SoftwareName   = "Recuva"
    Version        = "1.53.1"  # Set the correct version number
    Url            = "https://download.ccleaner.com/rcsetup153.exe"  # Set the correct download URL
    Checksum       = "YOUR_CHECKSUM_HERE"  # Replace with the actual checksum for the downloaded file
    ChecksumType   = "sha256"  # Use the appropriate checksum type
    SilentArgs     = "/S /L=$LCID"  # Set the silent installation arguments
    ValidExitCodes = @(0)
}

# Adds a registry key to prevent Google Chrome from installing with Piriform products
Start-ChocolateyProcessAsAdmin "& `'$PreventChromeInstall`'"

# Install
Install-ChocolateyPackage @packageArgs