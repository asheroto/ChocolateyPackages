# URL: https://download.fxsound.com/fxsoundlatest
$ErrorActionPreference = 'Stop'
$packageName    = 'fxsound'
$softwareName   = 'FxSound*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = 'B012939C2B0DA0CD5CCC2B3EE97ADC7B7017079A92FBB8351181EA4404C9F6C8'
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

Install-ChocolateyInstallPackage @packageArgs