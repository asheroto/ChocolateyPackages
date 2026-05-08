$ErrorActionPreference = 'Stop'

$packageName 		= 'ClickUp'
[array]$key 		= Get-UninstallRegistryKey -SoftwareName "$packageName"

# Exit if the package is already uninstalled
if($key.length -eq 0) { Return 0 }

$packageArgs = @{
	packageName    = $packageName
	fileType       = 'msi'
	file           = ($key[0].UninstallString -replace 'MsiExec\.exe /X', '')
	silentArgs     = '/qn /norestart'
	validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @packageArgs
