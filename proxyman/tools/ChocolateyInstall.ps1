$ErrorActionPreference = 'Stop'

$version = "3.16.1"
$url = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/${version}/Proxyman.Setup.${version}.exe"
$checksum = "6807F67C1B7650E5F1F57F26A2C8B8666201EC89F54CC2DF7A5FBC180F095EF2"

# Package args
$packageArgs = @{
    PackageName    = "proxyman"
    SoftwareName   = "Proxyman*"
    Version        = $version
    Url            = $url
    Checksum       = $checksum
    ChecksumType   = "sha256"
    SilentArgs     = "/S"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs
