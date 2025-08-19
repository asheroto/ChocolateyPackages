$ErrorActionPreference = "Stop"

# https://herd.laravel.com/windows

$Version = "1.22.0"

# Package args
$packageArgs = @{
    PackageName    = "Laravel Herd"
    SoftwareName   = "Laravel Herd"
    Url            = "https://download.herdphp.com/app_versions/Herd-${Version}-setup.exe"
    Checksum       = "E1DAC0B4817106B35A1CB26C33B78A36AE74418BAFE006E993BB1A20F0BCE576"
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