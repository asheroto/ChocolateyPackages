$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "ClickUp*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '{7E2C39C6-060D-4079-8A5C-8EA0EEAF768B} /qn'
$fileType			= 'msi'
$validExitCodes 	= @(0);

$packageArgs = @{
	packageName    = $packageName
	file           = $file
	silentArgs     = $silentArgs
	fileType       = $fileType
	validExitCodes = $validExitCodes
}

Uninstall-ChocolateyPackage @packageArgs