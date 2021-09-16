$ErrorActionPreference 	= 'Stop'
$packageName 			= 'metadataplusplus'
$softwareName 			= 'Metadata++*'
$silentArgs 			= '/verysilent'
$toolsPath      		= "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocation 			= "$toolsPath\metadata++-2-00-4.exe"
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