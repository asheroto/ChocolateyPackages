$ErrorActionPreference = "Stop"

# Language code
$LCID = (Get-Culture).LCID

# Package args
$packageArgs = @{
    PackageName    = "recuva"
    SoftwareName   = "Recuva"
    Version        = "1.53.2096"  # Set the correct version number
    Url            = "https://download.ccleaner.com/rcsetup153.exe"  # Set the correct download URL
    Checksum       = "B3DF198D64BA6F401611F56743BD344C1B02915F9E5D571D271EF8557FEAF56C"  # Replace with the actual checksum for the downloaded file
    ChecksumType   = "sha256"  # Use the appropriate checksum type
    SilentArgs     = "/S /L=$LCID"  # Set the silent installation arguments
    ValidExitCodes = @(0)
}

# ============================================================================ #
# PreventChromeInstall.ps1
# The script PreventChromeInstall.ps1 introduces a registry entry to block Google Chrome installation via Piriform products.
# Below, PreventChromeInstall.ps1 is executed as admin in a background job to minimize script output, reducing user confusion,
# stemming from Chocolatey issue #1016 https://github.com/chocolatey/choco/issues/1016
# ============================================================================ #

# Path to PreventChromeInstall.ps1
$PreventChromeInstall = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\PreventChromeInstall.ps1"

# Get the path to the Chocolatey module
$chocoModulePath = (Get-Module -Name Chocolatey* | Select-Object -First 1).ModuleBase

$scriptBlock = {
    param($PreventChromeInstall, $chocoModulePath)
    try {
        # Set the error action preference to silently continue to suppress errors
        $ErrorActionPreference = "SilentlyContinue"

        # Import the Chocolatey module using the provided path
        $modulePath = [System.IO.Path]::Combine($chocoModulePath, 'chocolatey', 'Installer.psm1')
        Import-Module $modulePath

        # Notify the user that the registry keys are being added
        Write-Host "Adding registry keys to prevent Google Chrome and Toolbar offers with Piriform products..." -ForegroundColor Cyan

        # Execute the Start-ChocolateyProcessAsAdmin cmdlet with the specified script
        Start-ChocolateyProcessAsAdmin "& `'$PreventChromeInstall`'" 2>&1 | Out-Null
    } catch {
        # Write any exceptions to the warning stream
        Write-Warning $_.Exception.Message
    }
}

# Start a background job to run the script block
$job = Start-Job -ScriptBlock $scriptBlock -ArgumentList $PreventChromeInstall, $chocoModulePath

# Wait for the background job to complete
$null = Receive-Job -Job $job -Wait

# Clean up the background job
Remove-Job -Job $job

# ============================================================================ #
# Install Chocolatey package
# ============================================================================ #

# Install
Install-ChocolateyPackage @packageArgs