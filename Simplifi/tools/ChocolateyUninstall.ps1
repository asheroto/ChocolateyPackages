$ErrorActionPreference = 'Stop'

$packageName = 'Simplifi'
$softwareName = 'Simplifi'
[array]$key = Get-UninstallRegistryKey -SoftwareName "$softwareName*"

# Exit if the package is already uninstalled
if (-not $key) { return $null }

$uninstallString = $key.UninstallString

# Check if silent uninstall arguments are already included
if ($uninstallString -notmatch '/qn') {
    $silentArgs = $uninstallString.Replace("MsiExec.exe /X", "").Trim() + " /qn"
} else {
    $silentArgs = $uninstallString
}

$packageArgs = @{
    packageName    = $packageName
    file           = 'MsiExec.exe'
    silentArgs     = $silentArgs
    fileType       = 'msi'
    validExitCodes = @(0)
}

Uninstall-ChocolateyPackage @packageArgs
