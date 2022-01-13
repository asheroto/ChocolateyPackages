$packageName 		= 'Coinomi'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "Coinomi*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString.Replace(" /uninstall", "");
$silentArgs 		= '/silent'
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