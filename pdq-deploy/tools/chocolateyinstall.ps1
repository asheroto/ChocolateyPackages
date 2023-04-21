# URL: http://www2.adminarsenal.com/download-pdqdeploy
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '480B6C2B8CBA57EB07800C9ECEE95FAC6872730760F0F47C35E8679E4603D3C8'
$silentArgs     = '/s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\Deploy_19.3.409.0.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs