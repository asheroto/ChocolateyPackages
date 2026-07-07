$ErrorActionPreference = 'Stop'

$version = "3.16.0"
$url = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/${version}/Proxyman.Setup.${version}.exe"
$checksum = "FA25AE25EAAAF72A76C11BDC13B8DE3A4A5B7DDA2DF268B067EE6C482EE3CA7C"

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
