$packageName 		= 'filemenutools'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "FileMenu Tools*"
$uninstallString 	= $key.UninstallString
$file 				= $uninstallString
$silentArgs 		= '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
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