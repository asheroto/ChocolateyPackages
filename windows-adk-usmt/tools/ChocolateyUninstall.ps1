#######################################
# Remove the User State Migration Tool from the PATH environment variable
#######################################

# Import the functions from the Functions.ps1 file
. "$PSScriptRoot\Functions.ps1"

# Output
Write-Section "Removing the User State Migration Tool from the PATH environment variable..."

# If the USMTPath environment variable exists, remove it
$usmtPath = Get-EnvironmentVariable -Name 'USMTPath' -Target 'Machine'
if ($null -ne $usmtPath) {
    Remove-EnvironmentVariable -Name 'USMTPath' -Target 'Machine'
    Update-SessionEnvironment
}