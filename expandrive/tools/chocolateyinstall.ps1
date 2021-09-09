$ErrorActionPreference	= 'Stop'
$packageName			= 'ExpanDrive'
$softwareName			= 'ExpanDrive*'
$toolsPath				= Split-Path $MyInvocation.MyCommand.Definition
$checksum				= 'd8401aa3f3ad7bb0d4735a1e4c4bfce08178052e0da340cc6b0ac814eaaa4d4b'
$silentArgs				= '/quiet'
$validExitCodes			= @(0)
$fileLocation			= "$toolsPath\ExpanDrive_Setup_2021.8.3.exe"

$packageArgs = @{
	packageName    = $packageName
	fileType       = 'exe'
	file           = $fileLocation
	checksum       = $checksum
	checksumType   = 'sha256'
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
	softwareName   = $softwareName
}
 
Install-ChocolateyPackage @packageArgs