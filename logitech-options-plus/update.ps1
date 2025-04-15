Write-Output ("-" * 60)
Write-Output "logitech-options-plus"
Write-Output ("-" * 60)

# Variables
$PackageName = "logitech-options-plus"
$nuspecFile = "logitech-options-plus.nuspec"
$AutoPush = $true
$versionTagPattern = '<version>(.*?)<\/version>'
$dependencyVersionPattern = '(<dependency id="logioptionsplus" version=")([^"]+)(" \/\>)'
$versionPattern = [regex]::new('Logi Options\+\s*([\d.]+)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
$url = "https://community.chocolatey.org/packages/logioptionsplus"
$alertSubject = "Logi Options+ Updated"
$alertMessageTemplate = "Logi Options+ has been updated to version {0}. Auto push enabled."

# Remember location
Push-Location

# Change folder to this script's folder
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Definition)

# Load the nuspec file content
$nuspecContent = Get-Content $nuspecFile -Raw

# Check the current version
$currentVersionMatch = [regex]::Match($nuspecContent, $versionTagPattern)
if ($currentVersionMatch.Success) {
    $currentVersion = $currentVersionMatch.Groups[1].Value
} else {
    Write-Output "Current version not found."
    exit
}

# Fetch the webpage content
$pageContent = Invoke-WebRequest -Uri $url -UseBasicParsing

# Use a regex pattern to extract the version number from the HTML content
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

        # Delete any nupkg files in the package folder if it exists
        $nupkgFiles = Get-ChildItem -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition) -Filter "*.nupkg"
        if ($nupkgFiles) {
            foreach ($nupkgFile in $nupkgFiles) {
                Write-Output "Deleting old nupkg file: $nupkgFile"
                Remove-Item -Path $nupkgFile.FullName -Force
            }
        }

        # Run 'choco pack' to create the nupkg file
        Write-Output "Creating nupkg file..."
        choco pack

        # Push the package to Chocolatey
        if ($AutoPush) {
            $filename = "$PackageName.$versionNumber.nupkg"
            Write-Output "Pushing $filename to Chocolatey..."
            choco push $filename
        }

        # Import the Chocolatey package updater functions
        . (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'functions.ps1')

        # Send Alert
        $alertMessage = [string]::Format($alertMessageTemplate, $versionNumber)
        SendAlert -Subject $alertSubject -Message $alertMessage
    } else {
        Write-Output "No new version available."
    }
} else {
    Write-Output "Version number not found."
    exit
}

# Return to the original location
Pop-Location