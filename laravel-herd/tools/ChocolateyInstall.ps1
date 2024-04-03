$ErrorActionPreference = "Stop"

# https://herd.laravel.com/windows

$Version = "1.0.1"

# Package args
$packageArgs = @{
    PackageName    = "Laravel Herd"
    SoftwareName   = "Laravel Herd"
    Url            = "https://download.herdphp.com/app_versions/Herd-${Version}-setup.exe"
    Checksum       = "5F599DDA478168CF3D6A4B938CB75F1E4B66D496C316E5A7582536290D7190EA"
    ChecksumType   = "sha256"
    SilentArgs     = "/S"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs