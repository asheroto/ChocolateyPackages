$ErrorActionPreference = 'Stop'
# Download URL: https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install

# Package vars
$ChocoPackage = @{
    packageName    = 'Windows Assessment and Deployment Kit - User State Migration Tool'
    url            = 'https://go.microsoft.com/fwlink/?linkid=2196127'
    checksum256    = 'FEA28F693139CDB55D2C993273B815147F804BB27BCB912F85ABAFC63FC6AAC8'
    silentArgs     = "/quiet /norestart /log $env:temp\win_adk_usmt.log /features OptionId.UserStateMigrationTool"
    fileType       = 'exe'
    validExitCodes = @(0, 3010)
}

# Install package
Install-ChocolateyPackage @ChocoPackage

#######################################
# Add USMT to PATH
#######################################

# Output
Write-Output "Adding the User State Migration Tool to the PATH environment variable..."

# Import the functions from the Functions.ps1 file
. "$PSScriptRoot\Functions.ps1"

# Call the function to get the KitsRoot
$adkPath = Get-WindowsAdkPath
if ($null -ne $adkPath) {
    # Build the path to the User State Migration Tool
    $usmtPath = Join-Path -Path $adkPath -ChildPath "User State Migration Tool\$($env:PROCESSOR_ARCHITECTURE)"

    # Build the path to the scanstate.exe
    $scanstatePath = Join-Path -Path $usmtPath -ChildPath "scanstate.exe"

    # Verify that the scanstate.exe exists
    if (Test-Path -Path $scanstatePath -ErrorAction SilentlyContinue) {
        # If it exists, add it to the PATH
        $PathType = [System.EnvironmentVariableTarget]::Machine
        Write-Host "The path '$usmtPath' will be added to PATH"
        Install-ChocolateyPath -pathToInstall $usmtPath -pathType $PathType
    } else {
        Write-Warning "Unable to find '$scanstatePath'"
    }
} else {
    Write-Warning "Unable to find the path to Windows ADK. Please add the path to the User State Migration Tool manually."
}