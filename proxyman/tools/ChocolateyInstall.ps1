$ErrorActionPreference = 'Stop'

$version = "3.7.0"
$url = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/${version}/Proxyman.Setup.${version}.exe"
$checksum = "3E47F06087FD46C7A59A6F0F25F2C9EFDC3D50E9F7282D4D84DBAEBFD79405FC"

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
