$ErrorActionPreference = 'Stop'
$packageName = 'httptoolkit'
$softwareName = 'httptoolkit'
$version = "1.24.4"
$url = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v${VERSION}/HttpToolkit-${VERSION}.exe"
$checksum = '2935EDF61BB1107A557946B204A2C4BB9A4AD568C7576BF27B4F6A1C258E3B59'
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