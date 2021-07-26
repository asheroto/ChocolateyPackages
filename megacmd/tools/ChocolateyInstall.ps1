$ErrorActionPreference = 'Stop'
$packageName    = 'megacmd'
$softwareName   = 'MEGAcmd'
$url32          = 'https://mega.nz/MEGAcmdSetup32.exe'
$checksum32     = '2c618a7030f251873aefba685ae84adf3b2d5696f9b421c04f5be6ef70f83136'
$url64          = 'https://mega.nz/MEGAcmdSetup64.exe'
$checksum64     = '6150fa3da6bc43fc597901fcd3ae3fae6cfd79ae94f362277d64f6d205939e91'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  url           = $url32
  url64bit      = $url64
  checksum      = $checksum32
  checksum64bit = $checksum64
  checksumType  = 'sha256'
  checksumType64 = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyPackage @packageArgs