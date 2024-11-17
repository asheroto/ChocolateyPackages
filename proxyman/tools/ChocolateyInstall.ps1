$ErrorActionPreference = 'Stop'

$version = "2.18.0"
$url = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/${version}/Proxyman.Setup.${version}.exe"
$checksum = "6C3E003A72B89726FED8D33AC758F3CBCC0DCE6329677E7E4437DFBB6AA97099"

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
