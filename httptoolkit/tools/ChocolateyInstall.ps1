$ErrorActionPreference = 'Stop'
$packageName = 'httptoolkit'
$softwareName = 'httptoolkit'
$version = "1.19.3"
$url = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v${VERSION}/HttpToolkit-installer-${VERSION}.exe"
$checksum = '717CB0DED14827B8DB25EDE37DE0E076C0E5B6E28495D31EEFCA090773333323'
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
