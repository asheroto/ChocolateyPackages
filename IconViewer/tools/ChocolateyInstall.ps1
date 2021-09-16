$ErrorActionPreference 	= 'Stop'
$packageName 			= 'iconviewer'
$softwareName 			= 'IconViewer*'
$silentArgs 			= '/quiet'
$toolsPath      		= "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocationX86		= "$toolsPath\IconViewer3.02-Setup-x86.exe"
$fileLocationX64		= "$toolsPath\IconViewer3.02-Setup-x64.exe"
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