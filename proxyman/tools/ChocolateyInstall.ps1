$ErrorActionPreference = 'Stop'

$version = "3.11.0"
$url = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/${version}/Proxyman.Setup.${version}.exe"
$checksum = "A9E3F777ABED11B573F81A1C74353183A997B209747BCBA6E0A68D7812B64007"

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
