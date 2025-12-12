[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# ============================================================================ #
# Update
# ============================================================================ #

# Set script and parent paths
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath
$VentoyPath = Join-Path $ParentPath "ventoy"

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# ============================================================================ #
# Get current nupkg version
# ============================================================================ #

# Get list of nupkg files
$packageFiles = Get-ChildItem -Path $VentoyPath -Filter "*.nupkg"

# Extract file version using regex
$existingPackageFileVersion = $packageFiles.Name -replace '.*?(\d+\.\d+\.\d+).*', '$1'

# Define package info
$packageInfo = @{
    PackageName   = "ventoy"
    FileUrl       = "https://github.com/ventoy/Ventoy/releases/download/v{VERSION}/ventoy-{VERSION}-windows.zip"
    GitHubRepoUrl = "https://github.com/ventoy/Ventoy"
    AutoPush      = $true
    EnvFilePath   = "..\.env"
    Alert         = $false
}

# Call the update function
UpdateChocolateyPackage @packageInfo

# ============================================================================ #
# Modify version number for Ventoy
# ============================================================================ #

Write-Output "Modifying version number for Ventoy"

# Define repository details
$RepoOwner = "ventoy"
$RepoName = "Ventoy"

# Get the latest version from GitHub
$releaseInfo = Get-GitHubRelease -Owner $RepoOwner -Repo $RepoName

# Remove "v" in $releaseInfo.LatestVersion
$latestVersion = $releaseInfo.LatestVersion -replace '^v', ''

# Normalize version for comparison
$versionWithoutLeadingZeroes = $latestVersion -replace '\b0+(\d+)', '$1'
Write-Output "versionWithoutLeadingZeroes: $versionWithoutLeadingZeroes"
Write-Output "existingPackageFileVersion: $existingPackageFileVersion"

# Exit if versions match
if ($versionWithoutLeadingZeroes -eq $existingPackageFileVersion) {
    Write-Output "Latest Ventoy version is the same as the current version. Exiting..."
    exit
}

Write-Output "Latest Ventoy Version: $latestVersion"

# Define ChocolateyInstall.ps1 path
$chocolateyInstallPath = Join-Path $VentoyPath "tools\ChocolateyInstall.ps1"

# Ensure ChocolateyInstall.ps1 exists before proceeding
if (-Not (Test-Path $chocolateyInstallPath)) {
    Write-Error "ChocolateyInstall.ps1 not found at $chocolateyInstallPath"
    exit 1
}

# Update ChocolateyInstall.ps1 with the latest version
$chocolateyInstall = Get-Content $chocolateyInstallPath
$chocolateyInstall = $chocolateyInstall -replace '\$version = "\d+\.\d+\.\d+"', "`$version = `"$latestVersion`""
Set-Content -Path $chocolateyInstallPath -Value $chocolateyInstall

# Remember current location and switch to Ventoy directory
Push-Location
Set-Location -Path $VentoyPath

# ============================================================================ #
# Repackage & push the Chocolatey package
# ============================================================================ #

# Repackage the Chocolatey package
choco pack

# Define package path
$packagePath = Join-Path $PSScriptRoot "$($packageInfo.PackageName).$versionWithoutLeadingZeroes.nupkg"
Write-Output "Pushing package: $packagePath"

# Push the package
choco push $packagePath

# ============================================================================ #
# Alert
# ============================================================================ #

# Import alert functions
. (Join-Path $ParentPath 'functions.ps1')

# Define alert details
$alertSubject = "Ventoy Updated"
$alertMessage = "Ventoy has been updated to version ${version}. Auto push enabled."

# Send alert
SendAlert -Subject $alertSubject -Message $alertMessage

# Restore previous location
Pop-Location