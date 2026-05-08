$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$softwareName = 'Messages for Web'
$key = Get-UninstallRegistryKey -SoftwareName "$softwareName*" | Select-Object -First 1

# Exit if the package is already uninstalled
if (-not $key) { return $null }

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'msi'
    file           = ($key.UninstallString -replace 'MsiExec\.exe /X', '')
    silentArgs     = '/qn /norestart'
    validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @packageArgs