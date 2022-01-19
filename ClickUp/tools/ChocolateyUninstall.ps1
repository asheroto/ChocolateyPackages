$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "ClickUp*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '{50089E6C-44CC-42AC-B6CE-E7C70FC4436D} /qn'
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