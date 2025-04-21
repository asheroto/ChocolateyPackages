$ErrorActionPreference = "Stop"

# https://herd.laravel.com/windows

$Version = "1.19.1"

# Package args
$packageArgs = @{
    PackageName    = "Laravel Herd"
    SoftwareName   = "Laravel Herd"
    Url            = "https://download.herdphp.com/app_versions/Herd-${Version}-setup.exe"
    Checksum       = "CA553BC055DCC78257CF7F374BF7A07D8D8C02FEA9D0A2A5325E7E084813ABE4"
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