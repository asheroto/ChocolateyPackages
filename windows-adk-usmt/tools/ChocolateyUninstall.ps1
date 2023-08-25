#######################################
# Remove USMT from PATH
#######################################

# Output
Write-Output "Removing the User State Migration Tool from the PATH environment variable..."

# Import the functions from the Functions.ps1 file
. "$PSScriptRoot\Functions.ps1"

# Call the function to get the KitsRoot
$adkPath = Get-WindowsAdkPath

# If the adkPath is null, return
if ($null -eq $adkPath) {
    Write-Warning "Unable to find the path to Windows ADK. Please remove the path to the User State Migration Tool manually."
    return
}

# Build the path to the User State Migration Tool
$usmtPath = Join-Path -Path $adkPath -ChildPath "User State Migration Tool\$($env:PROCESSOR_ARCHITECTURE)"

# If the usmtPath does not exist, return
if (-not (Test-Path -Path $usmtPath -ErrorAction SilentlyContinue)) {
    Write-Warning "Unable to find the path to User State Migration Tool. Please remove the path manually."
    return
}

# Update session environment and retrieve the PATH variable
Update-SessionEnvironment
$EnvPath = $env:PATH

# Default success to false
$success = $false

# Check if the path to User State Migration Tool exists in the PATH variable
if ($EnvPath.ToLower().Contains($usmtPath.ToLower())) {
    # Split the PATH variable into an array
    $PathArray = $EnvPath.Split(';')

    # Remove the USMT path
    $NewPathArray = $PathArray | Where-Object { $_ -ne $usmtPath }

    # Join the array back into a string
    $NewPath = $NewPathArray -join ';'

    # Update the PATH variable with the new value
    $VariableType = [System.EnvironmentVariableTarget]::Machine
    Install-ChocolateyEnvironmentVariable -variableName 'Path' -variableValue $NewPath -variableType $VariableType

    Write-Output "Successfully removed the User State Migration Tool from the PATH environment variable."
} else {
    Write-Warning "The path for the User State Migration Tool is not in the PATH environment variable."

    # Update session environment again
    Update-SessionEnvironment
    $EnvPath = $env:PATH

    Write-Output "Testing scanstate.exe command..."
    if (Get-ScanStateStatus -eq $true) {
        # If scanstate works, set success to false, because the PATH is not correct
        Write-Warning "scanstate.exe still works from the command line, please remove its folder from the PATH variable manually."
        $success = $false
    } else {
        # If scanstate does not work, set success to true, because the PATH is correct
        Write-Output "scanstate.exe does not work from the command line, the PATH variable is correct and no action is required."
        $success = $true
    }
}