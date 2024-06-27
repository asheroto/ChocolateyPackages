$ErrorActionPreference = "Stop"

# PreventChromeInstall.ps1 adds a registry entry to block Google Chrome installation via Piriform products.
Write-Output "Adding registry keys to prevent Google Chrome and Toolbar offers with Piriform products."
$preventChromeInstallPath = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "PreventChromeInstall.ps1")
& $preventChromeInstallPath

# Language code
if ($Env:ChocolateyPackageParameters -match '/UseSystemLocale') {
    Write-Output "Using system locale"
    $locale = "/L=" + (Get-Culture).LCID
}

# Package args
$packageArgs = @{
    PackageName    = "recuva"
    SoftwareName   = "Recuva"
    Version        = '1.54.120'
    Url            = 'https://download.ccleaner.com/rcsetup154.exe'
    Checksum       = 'dbf0895d886b428c8465ee57aea56a7e7b6e4c003efd04ca00d216a2d821eac9'
    ChecksumType   = "sha256"
    SilentArgs     = "/S $locale"
    ValidExitCodes = @(0, "-1073741819") # Odd return code from Recuva, but it does install successfully
}

# Install Chocolatey package
Install-ChocolateyPackage @packageArgs