$packageName 		= 'iconviewer'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "IconViewer*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString.Replace(" /uninstall", "");
$silentArgs 		= '/uninstall /quiet'
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