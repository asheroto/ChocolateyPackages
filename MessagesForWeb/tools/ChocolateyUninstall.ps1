$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$softwareName = 'Messages for Web'
$key = Get-UninstallRegistryKey -SoftwareName "$softwareName*" | Select-Object -First 1

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