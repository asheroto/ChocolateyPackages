$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "$packageName"

# Exit if the package is already uninstalled
if($key.length -eq 0) { Return 0 }

$uninstallString 	= $key[0].UninstallString
$file 				= $uninstallString
$silentArgs 		= $uninstallString.Replace("MsiExec.exe /X", "") + " /qn"
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