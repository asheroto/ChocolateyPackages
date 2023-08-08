$ErrorActionPreference = 'Stop'
$packageName 		= 'TablePlus'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "TablePlus*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '/SILENT'
$fileType			= 'exe'
$validExitCodes 	= @(0);

$packageArgs = @{
	packageName    = $packageName
	file           = $file
	silentArgs     = $silentArgs
	fileType       = $fileType
	validExitCodes = $validExitCodes
}

Uninstall-ChocolateyPackage @packageArgs
