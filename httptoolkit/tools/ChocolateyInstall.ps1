$ErrorActionPreference = 'Stop'
$packageName = 'httptoolkit'
$softwareName = 'httptoolkit'
$version = "1.26.1"
$url = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v${VERSION}/HttpToolkit-${VERSION}.exe"
$checksum = '9687B9169D86FBBEF203614162958ED6373467A17EEB036C24424A39960CFC51'
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