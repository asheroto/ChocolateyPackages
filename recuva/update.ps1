[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

Write-Output ("-" * 60)
Write-Output "recuva"
Write-Output ("-" * 60)

# Variables
$AutoPush = $false
$apiUrl = 'https://www.ccleaner.com/recuva/version-history'
$nuspecFilePath = Resolve-Path "recuva.nuspec"
$installScriptPath = Resolve-Path ".\tools\chocolateyInstall.ps1"
$currentVersionPattern = [regex]::new('<version>(.*?)</version>')
$alertSubject = "Recuva Updated"
$alertMessageTemplate = "Recuva has been updated to version {0}. Auto push NOT enabled. Current version is {1}."
$recuvaFileUrlTemplate = "https://download.ccleaner.com/rcsetup{0}.exe"
$recuvaFilenameTemplate = "recuva.{0}.nupkg"
$AutoPush = $false

# Remember location
Push-Location

# Change folder to this script's folder
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Definition)

# Function to get the latest version and download URL
function Get-LatestVersionAndUrl {
    $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
    $html = $response.Content

    # Extract version number from the span with data-qa-id="version-history__latest-version"
    $versionPattern = [regex]::new('<span[^>]*data-qa-id="version-history__latest-version"[^>]*>v([\d\.]+)</span>', 'IgnoreCase')
    $versionMatch = $versionPattern.Match($html)

    if ($versionMatch.Success) {
        $version = $versionMatch.Groups[1].Value
        Write-Output "Found version: $version"

        $fileUrl = [string]::Format($recuvaFileUrlTemplate, $version.Replace('.', ''))

        return @{
            URL32   = $fileUrl
            Version = $version
        }
    } else {
        Write-Output "Version number not found."
        exit 1
    }
}

# Get the current version from the nuspec file
$currentNuspecContent = Get-Content $nuspecFilePath -Raw
$currentVersionMatch = $currentVersionPattern.Match($currentNuspecContent)
$currentVersion = if ($currentVersionMatch.Success) { $currentVersionMatch.Groups[1].Value } else { '' }

# Get the latest version and URL
$Latest = Get-LatestVersionAndUrl

# Write the latest version
Write-Output "Latest Version: $($Latest.Version)"

if ($Latest.Version -ne $currentVersion -and $currentVersion -ne '') {
    Write-Output "Version has changed from $currentVersion to $($Latest.Version). Updating files..."

    # Calculate the checksum
    $checksum = Get-RemoteChecksum -Url $Latest.URL32

    # Update version in nuspec file using regex replacement
    $nuspecContent = [regex]::Replace($currentNuspecContent, '(<version>)(.*?)(</version>)', "<version>$($Latest.Version)</version>")
    Set-Content -Path $nuspecFilePath -Value $nuspecContent -Encoding utf8NoBOM
    Write-Output "Updated version in nuspec file to $Latest.Version."

    # Read the ChocolateyInstall.ps1 script content
    $installScriptContent = Get-Content $installScriptPath -Raw

    # Update the URL, checksum, and version in ChocolateyInstall.ps1 script using regex replacement
    $installScriptContent = $installScriptContent `
        -replace "(?<=Url\s*=\s*')[^']*", "$($Latest.URL32)" `
        -replace "(?<=Checksum\s*=\s*')[^']*", "$checksum" `
        -replace "(?<=Version\s*=\s*')[^']*", "$($Latest.Version)"

    Set-Content -Path $installScriptPath -Value $installScriptContent -Encoding utf8NoBOM
    Write-Output "Updated URL, checksum, and version in ChocolateyInstall.ps1 script."

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
        $filename = [string]::Format($recuvaFilenameTemplate, $Latest.Version)
        Write-Output "Pushing $filename to Chocolatey..."
        choco push $filename
    }

    # Import the Chocolatey package updater functions
    . (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'functions.ps1')

    # Send Alert
    $alertMessage = [string]::Format($alertMessageTemplate, $Latest.Version, $currentVersion)
    SendAlert -Subject $alertSubject -Message $alertMessage
} else {
    Write-Output "Version has not changed. No updates required."
}

# Return to the original location
Pop-Location