# URL: https://download.fxsound.com/fxsoundlatest
$ErrorActionPreference = 'Stop'
$packageName    = 'fxsound'
$softwareName   = 'FxSound*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '30B83FFBB9CC218AAB58696DEE25856C98359D5DF2157503E010DDD91E24D1A9'
$silentArgs     = '/exenoui /qn /norestart'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\fxsound_setup.exe"

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