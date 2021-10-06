$ErrorActionPreference 	= 'Stop'
$packageName 			= 'visualstudio2022-community-preview'
$softwareName 			= 'visualstudio2022-community-preview*'
$silentArgs 			= '--quiet'
$toolsPath      		= "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocationX86		= "$toolsPath\vs_community_2022.exe"
$fileLocationX64		= "$toolsPath\vs_community_2022.exe"
$fileType 				= 'exe'
$validExitCodes 		= @(0)

$packageArgs = @{
	packageName    = $packageName
	fileType       = $fileType
	file           = $fileLocationX86
	file64         = $fileLocationX64
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
	softwareName   = $softwareName
}

Install-ChocolateyInstallPackage @packageArgs