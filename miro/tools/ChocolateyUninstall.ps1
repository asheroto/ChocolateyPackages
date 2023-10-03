$ErrorActionPreference = 'Stop'

[array]$key = Get-UninstallRegistryKey -SoftwareName "Miro*"
$uninstallString = $key.UninstallString

$packageArgs = @{
    packageName    = 'miro'
    file           = $uninstallString.Replace("--uninstall", "")
    silentArgs     = '--uninstall -s'
    fileType       = 'exe'
    validExitCodes = @(0)
}

Uninstall-ChocolateyPackage @packageArgs