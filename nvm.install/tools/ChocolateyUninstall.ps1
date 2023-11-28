# Set error action preference to stop on errors
$ErrorActionPreference = 'Stop'

# Define package configuration
$packageName = 'nvm.install'
$packageSearch = 'NVM for Windows*'
$fileType = 'exe'
$silentArgs = '/SILENT /SUPPRESSMSGBOXES'
$validExitCodes = @(0)

# Registry paths to search for installed packages
$registryPaths = @(
    'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

# Search and uninstall the package
$registryPaths | ForEach-Object {
    Get-ItemProperty -Path $_ -ErrorAction SilentlyContinue |
    Where-Object { $_.DisplayName -like $packageSearch } |
    ForEach-Object {
        Uninstall-ChocolateyPackage -PackageName $packageName `
            -FileType $fileType `
            -SilentArgs $silentArgs `
            -File ($_.UninstallString -replace '"', '') `
            -ValidExitCodes $validExitCodes
    }
}