$ErrorActionPreference = 'Stop'
$version = "1.3.3"

$packageName    = 'qFlipper'
$softwareName   = 'qFlipper*'
$url            = "https://update.flipperzero.one/builds/qFlipper/${version}/qFlipperSetup-64bit-${version}.exe"
$checksum       = '0AD49533997A8FEDFEC9525CE2F0BE1860D66D5AE8625164717059CF03512BBA'
$silentArgs     = '/S'
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

Install-ChocolateyPackage @packageArgs
