# Load the nuspec file content
$nuspecFile = "logitech-options-plus.nuspec"
$nuspecContent = Get-Content $nuspecFile -Raw

# Define regex patterns for the version and dependency version
$versionTagPattern = '<version>(.*?)<\/version>'
$dependencyVersionPattern = '(<dependency id="logioptionsplus" version=")([^"]+)(" \/\>)'

# Define 

# Check the current version
$currentVersionMatch = [regex]::Match($nuspecContent, $versionTagPattern)
if ($currentVersionMatch.Success) {
    $currentVersion = $currentVersionMatch.Groups[1].Value
} else {
    Write-Output "Current version not found."
    exit
}

# Fetch the webpage content
$url = "https://community.chocolatey.org/packages/logioptionsplus"
$pageContent = Invoke-WebRequest -Uri $url -UseBasicParsing

# Use a regex pattern to extract the version number from the HTML content
$versionPattern = [regex]::new('Logi Options\+\s*([\d.]+)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
$versionMatch = $versionPattern.Match($pageContent.Content)

# Check if a match is found and output the version number
if ($versionMatch.Success) {
    $versionNumber = $versionMatch.Groups[1].Value
    Write-Output "Version Number: $versionNumber"

    # Compare the fetched version number with the current version number
    if ($versionNumber -ne $currentVersion) {
        Write-Output "New version available: $versionNumber"

        # Update the main version
        $nuspecContent = [regex]::Replace($nuspecContent, $versionTagPattern, "<version>$versionNumber</version>")

        # Update the dependency version
        $nuspecContent = [regex]::Replace($nuspecContent, $dependencyVersionPattern, "<dependency id=`"logioptionsplus`" version=`"$versionNumber`" />")

        # Save the updated content back to the nuspec file
        Set-Content -Path $nuspecFile -Value $nuspecContent -Encoding UTF8

        Write-Output "Version number updated to: $versionNumber"

        # Import the Chocolatey package updater functions
        . (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'functions.ps1')

        # Send Alert
        SendAlert -Subject "Logi Options+ Updated" -Message "Logi Options+ has been updated to version $versionNumber."
    } else {
        Write-Output "No new version available."
    }
} else {
    Write-Output "Version number not found."
    exit
}