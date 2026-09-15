$ErrorActionPreference = 'Stop'

[array]$key = Get-UninstallRegistryKey -SoftwareName 'System Informer'

if ($key.Count -eq 1) {
    # UninstallString format: "C:\Program Files\SystemInformer\systeminformer-setup.exe" -uninstall
    if ($key[0].UninstallString -notmatch '^"?([^"]+?\.exe)') {
        throw "Unexpected UninstallString: $($key[0].UninstallString)"
    }

    $packageArgs = @{
        packageName    = $env:ChocolateyPackageName
        fileType       = 'exe'
        file           = $matches[1]
        silentArgs     = '-uninstall -silent'
        validExitCodes = @(0)
    }

    Uninstall-ChocolateyPackage @packageArgs
} elseif ($key.Count -eq 0) {
    Write-Warning "$env:ChocolateyPackageName has already been uninstalled by other means."
} else {
    Write-Warning "$($key.Count) matches found! To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert the package maintainer that the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
