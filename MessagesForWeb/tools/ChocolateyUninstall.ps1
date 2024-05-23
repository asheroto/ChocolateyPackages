$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$key = Get-UninstallRegistryKey -SoftwareName "Messages for Web*" | Select-Object -First 1

# Exit if the package is already uninstalled
if (-not $key) { return $null }

$uninstallString = $key.UninstallString
$silentArgs = $uninstallString.Replace("MsiExec.exe /X", "").Trim() + " /qn"

$packageArgs = @{
    packageName    = $packageName
    file           = 'MsiExec.exe'
    silentArgs     = $silentArgs
    fileType       = 'msi'
    validExitCodes = @(0)
}

Uninstall-ChocolateyPackage @packageArgs