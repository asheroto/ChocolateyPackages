$ErrorActionPreference = 'Stop'
# Adds a registry key to prevent Google Chrome from installing with Piriform products

Function Add-PiriformRegistryKey {
    <#
    .SYNOPSIS
    Adds a registry key property to prevent Google Chrome and Toolbar offers with Piriform products.
    #>
    Param(
        [string]$RegistryPath
    )
    # Ensure the registry directory exists
    if (-not (Test-Path $RegistryPath)) {
        New-Item $RegistryPath -ItemType Directory -Force | Out-Null
    }

    # Set the property value
    New-ItemProperty -Path $RegistryPath -Name "Piriform Ltd" -PropertyType DWORD -Value 20991231 -Force | Out-Null
}

# Registry paths
$regDirChrome = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDirToolbar = 'HKLM:\SOFTWARE\Google\No Toolbar Offer Until'

# Adjust the paths for 64-bit system
if ([Environment]::Is64BitOperatingSystem) {
    $regDirChrome = 'HKLM:\SOFTWARE\Wow6432Node\Google\No Chrome Offer Until'
    $regDirToolbar = 'HKLM:\SOFTWARE\Wow6432Node\Google\No Toolbar Offer Until'
}

# Add the registry properties
Add-PiriformRegistryKey -RegistryPath $regDirChrome
Add-PiriformRegistryKey -RegistryPath $regDirToolbar