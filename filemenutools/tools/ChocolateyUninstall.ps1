$ErrorActionPreference 	= 'Stop'

# Package vars
$packageName 		= 'filemenutools'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "FileMenu Tools*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$fileType			= 'exe'
$validExitCodes 	= @(0);

# Package args
$packageArgs = @{
	packageName    = $packageName
	file           = $file
	silentArgs     = $silentArgs
	fileType       = $fileType
	validExitCodes = $validExitCodes
}

# Uninstall
Uninstall-ChocolateyPackage @packageArgs

# Output to user
Write-Output "You may need to restart your computer in order for FileMenu Tools to be completely removed."