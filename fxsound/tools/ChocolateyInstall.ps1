# URL: https://download.fxsound.com/fxsoundlatest
$ErrorActionPreference = 'Stop'
$packageName    = 'fxsound'
$softwareName   = 'FxSound*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '3B6427A62678DFDF9370D0B85A0DA6A02CEBF4E047C7E86C7B2C0208A2C5283B'
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