$ErrorActionPreference = 'Stop'

# Define the Microsoft Store ID
$msStoreID = "9nt1r1c2hh7j"

# Uninstall the Microsoft Store app using Winget, accepting all license agreements
Write-Output "Uninstalling app with Microsoft Store ID $msStoreID from the Microsoft Store using Winget..."
Start-Process -NoNewWindow -Wait -FilePath winget -ArgumentList "uninstall --id $msStoreID --source msstore --silent"

# Check if the uninstallation succeeded
# echo "Last exit code: $LASTEXITCODE"
if ($null -eq $LASTEXITCODE -or $LASTEXITCODE -eq 0) {
    Write-Output "Uninstallation completed successfully."
} else {
    Write-Output "Uninstallation failed. Please verify the Microsoft Store ID and try again."
    throw "The uninstallation did not complete successfully."
}