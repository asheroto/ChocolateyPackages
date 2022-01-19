$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "ClickUp*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '{B99169CC-B41D-4EC3-89FC-B46BA85414F5} /qn'
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