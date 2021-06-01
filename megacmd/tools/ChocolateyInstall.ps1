$bits           = Get-ProcessorBits
$ErrorActionPreference = 'Stop'
$packageName    = 'megacmd'
$softwareName   = 'MEGAcmd'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$url32          = 'https://mega.nz/MEGAcmdSetup32.exe'
$checksum32     = '2c618a7030f251873aefba685ae84adf3b2d5696f9b421c04f5be6ef70f83136'
$url64          = 'https://mega.nz/MEGAcmdSetup64.exe'
$checksum64     = '6150fa3da6bc43fc597901fcd3ae3fae6cfd79ae94f362277d64f6d205939e91'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\MEGAcmdSetup.1.4.0.0.exe"

if($bits -eq 64) {
    $url = $url64
    $checksum = $checksum64
} else {
    $url = $url32
    $checksum = $checksum32
}

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