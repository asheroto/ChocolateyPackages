$ErrorActionPreference 	= 'Stop'
$packageName 			= 'filemenutools'
$softwareName 			= 'FileMenu Tools*'
$silentArgs 			= '/VERYSILENT /NORESTART'
$toolsPath      		= "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocation			= "$toolsPath\FileMenuTools-setup.exe"
$fileType 				= 'exe'
$validExitCodes 		= @(0)

$packageArgs = @{
	packageName    = $packageName
	fileType       = $fileType
	file           = $fileLocation
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
	softwareName   = $softwareName
}

Install-ChocolateyInstallPackage @packageArgs