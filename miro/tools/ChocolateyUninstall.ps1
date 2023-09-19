$packageName = 'miro'
[array]$key = Get-UninstallRegistryKey -SoftwareName "Miro*"
$uninstallString = $key.UninstallString
$file = $uninstallString.Replace("--uninstall", "");
$silentArgs = '--uninstall -s'
$fileType = 'exe'
$validExitCodes = @(0);

Write-Output $file
Write-Output $silentArgs

$packageArgs = @{
    packageName    = $packageName
    file           = $file
    silentArgs     = $silentArgs
    fileType       = $fileType
    validExitCodes = $validExitCodes
}

Uninstall-ChocolateyPackage @packageArgs