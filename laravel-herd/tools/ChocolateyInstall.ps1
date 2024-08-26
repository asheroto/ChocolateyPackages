$ErrorActionPreference = "Stop"

# https://herd.laravel.com/windows

$Version = "1.10.0"

# Package args
$packageArgs = @{
    PackageName    = "Laravel Herd"
    SoftwareName   = "Laravel Herd"
    Url            = "https://download.herdphp.com/app_versions/Herd-${Version}-setup.exe"
    Checksum       = "4C030B96EAAE9850730435231E7709CBC522568AB6B0F7239FEE6076AA0D0A4D"
    ChecksumType   = "sha256"
    SilentArgs     = "/S"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs

# `t = tab
Write-Output ("-" * 40)
Write-Output ""
Write-Output "To get started, open the `"Herd`" desktop icon, or search for `"Herd`" in the Start Menu."
Write-Output ""
Write-Output "If this is the first time using Herd on this computer, you will need to complete the steps on first launch."
Write-Output ""
Write-Output "Documentation: https://herd.laravel.com/docs/windows"
Write-Output ""
Write-Output ("-" * 40)