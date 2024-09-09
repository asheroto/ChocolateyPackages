$ErrorActionPreference = 'Stop'
$packageName = 'httptoolkit'
$softwareName = 'httptoolkit'
$version = "1.19.0"
$url = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v${VERSION}/HttpToolkit-installer-${VERSION}.exe"
$checksum = '347BF097CB0826BE9F30FA693C36F6348701E94ED16A56F2777E1D4DF5ED9F05'
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
