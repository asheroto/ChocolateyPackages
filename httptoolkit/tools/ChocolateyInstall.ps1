$ErrorActionPreference = 'Stop'
$packageName = 'httptoolkit'
$softwareName = 'httptoolkit'
$version = "1.25.0"
$url = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v${VERSION}/HttpToolkit-${VERSION}.exe"
$checksum = '8264D5F877E1361ED3ECB7251F18129BC12E9FE951787DD204BF8A0B7E5FCF1E'
$silentArgs = '/S'
$validExitCodes = @(0)

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    file           = $fileLocation
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = $softwareName
}

# Install the package
Install-ChocolateyPackage @packageArgs