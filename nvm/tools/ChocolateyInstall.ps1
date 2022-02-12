$ErrorActionPreference	= 'Stop'
$packageName			= 'nvm'
$softwareName			= 'nvm*'
$toolsPath				= Split-Path $MyInvocation.MyCommand.Definition
$checksum				= '4B16E9289A41527F17ECA80C745688C6AF6D10A882294BF94B2ED71C80FA42EF'
$silentArgs				= '/verysilent /norestart'
$validExitCodes			= @(0)
$fileLocation			= "$toolsPath\nvm-setup.exe"

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