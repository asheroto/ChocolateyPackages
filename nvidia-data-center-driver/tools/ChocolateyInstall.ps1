$ErrorActionPreference = 'Stop'
$packageName    = 'nvidia-data-center-driver'
$softwareName   = 'NVIDIA Data Center Driver*'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$url            = 'https://us.download.nvidia.com/tesla/462.31/462.31-data-center-tesla-desktop-winserver-2019-2016-international.exe' 
$checksum       = '92da4be08254a43cba5d7ba7c7f86d5c44cfc5bbf5e5537a8f378e31f96bc34f'		
$silentArgs     = '-s'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\NVIDIA_Data_Center_Driver.exe"

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

Write-Color
Write-Color -Text "If the installation ", "SUCCEEDS", ", you may need to restart your computer to fully load everything" -Color Yellow,Green,Yellow
Write-Color
Write-Color -Text "If the installation ", "FAILS", ", your graphics card may not be compatible. You can download and run the install manually:" -Color Yellow,Red,Yellow
Write-Color -Text "$url" -Color Yellow
Write-Color

Install-ChocolateyPackage @packageArgs