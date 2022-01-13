$ErrorActionPreference  = 'Stop'
$packageName    = 'Coinomi'
$softwareName   = 'Coinomi Wallet'
$url            = 'https://storage.coinomi.com/binaries/desktop/coinomi-wallet-1.3.0-win64.exe'
$checksum       = 'e7bc8930166a0c0e70cc17de1fc83e7cbac864d684af05468a8e7f8426038cf7'
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs