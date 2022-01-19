$packageName 		= 'Messages for web'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "Messages for web*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '{E4D364B1-9D31-471A-A747-CEFB8C8F7712} /qn'
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