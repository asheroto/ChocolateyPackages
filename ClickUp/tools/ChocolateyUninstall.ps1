$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "ClickUp*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '{EADA8BB4-9DBE-473B-B990-28D6538BC5B2} /qn'
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