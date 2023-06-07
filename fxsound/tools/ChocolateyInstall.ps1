# URL: https://download.fxsound.com/fxsoundlatest
$ErrorActionPreference = 'Stop'
$packageName    = 'fxsound'
$softwareName   = 'FxSound*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$checksum       = '3E28779529180D53B21E78708E1C7411FF0312D8416151AC8312DE19D43F80AE'
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