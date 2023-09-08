$ErrorActionPreference 	= 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package vars
$packageName 			= 'filemenutools'
$softwareName 			= 'FileMenu Tools*'
$silentArgs 			= '/VERYSILENT /NORESTART'
$toolsPath      		= "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$fileLocation			= "$toolsPath\FileMenuTools-setup.exe"
$fileType 				= 'exe'
$validExitCodes 		= @(0)

# Package args
$packageArgs = @{
	packageName    = $packageName
	fileType       = $fileType
	file           = $fileLocation
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
	softwareName   = $softwareName
}

# Install
Install-ChocolateyInstallPackage @packageArgs

# Output to user
Write-Output "You may need to restart your computer in order for FileMenu Tools to work as expected."