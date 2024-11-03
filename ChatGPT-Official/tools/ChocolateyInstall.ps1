$ErrorActionPreference = 'Stop'

# Define the Microsoft Store ID
$msStoreID = "9nt1r1c2hh7j"

# Install the Microsoft Store app using Winget, accepting all license agreements
Write-Output "Installing app with Microsoft Store ID $msStoreID from the Microsoft Store using Winget..."
Start-Process -NoNewWindow -Wait -FilePath winget -ArgumentList "install --id $msStoreID --source msstore --silent --accept-package-agreements --accept-source-agreements"

# Check if the installation succeeded
# echo "Last exit code: $LASTEXITCODE"
if ($null -eq $LASTEXITCODE -or $LASTEXITCODE -eq 0) {
    Write-Output "Installation completed successfully."
} else {
    Write-Output "Installation failed. Please verify the Microsoft Store ID and try again."
    throw "The installation did not complete successfully."
}