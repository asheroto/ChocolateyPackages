[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "ventoy"
    FileUrl       = "https://github.com/ventoy/Ventoy/releases/download/v{VERSION}/ventoy-{VERSION}-windows.zip"
    GitHubRepoUrl = "https://github.com/ventoy/Ventoy"
    AutoPush      = $false
    EnvFilePath   = "..\.env"
    Alert         = $false
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo

# ============================================================================ #
# Modify version number for Ventoy
# ============================================================================ #

Write-Output "Modifying version number for Ventoy"

# Dot-source Chocolatey-Package-Updater.ps1 from the parent directory
. (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'Chocolatey-Package-Updater.ps1')

# Define repository details
$RepoOwner = "ventoy"
$RepoName = "Ventoy"

# Get the latest version from GitHub
$releaseInfo = Get-GitHubRelease -Owner $RepoOwner -Repo $RepoName
$version = $releaseInfo.LatestVersion -replace '^v', ''  # Remove leading 'v' if present

Write-Output "Latest Ventoy Version: $version"

# Define ChocolateyInstall.ps1 path
$chocolateyInstallPath = [System.IO.Path]::Combine($PSScriptRoot, "tools", "ChocolateyInstall.ps1")

# Ensure ChocolateyInstall.ps1 exists before proceeding
if (-Not (Test-Path $chocolateyInstallPath)) {
    Write-Error "ChocolateyInstall.ps1 not found at $chocolateyInstallPath"
    exit 1
}

# Read and update ChocolateyInstall.ps1 with the latest version
$chocolateyInstall = Get-Content $chocolateyInstallPath
$chocolateyInstall = $chocolateyInstall -replace '\$version = "\d+\.\d+\.\d+"', "`$version = `"$version`""

# Uncomment the line below to apply changes
Set-Content -Path $chocolateyInstallPath -Value $chocolateyInstall

# ============================================================================ #
# Repackage & push the Chocolatey package
# ============================================================================ #

# Repackage the Chocolatey package
choco pack

# Define the nupkg path by combining package name and version and push the package
$normalizedVersion = ($version -split '\.') -join '.'
$normalizedVersion = $normalizedVersion -replace '\b0+(\d+)', '$1'
$packagePath = [System.IO.Path]::Combine($PSScriptRoot, "$($packageInfo.PackageName).$normalizedVersion.nupkg")
Write-Output "Pushing package: $packagePath"

# Push the package
choco push $packagePath

# ============================================================================ #
# Alert
# ============================================================================ #

# Import the Chocolatey package updater functions
. (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'functions.ps1')

# Define vars
$alertSubject = "Ventoy Updated"
$alertMessage = "Ventoy has been updated to version ${normalizedVersion}. Auto push enabled."

# Send Alert
SendAlert -Subject $alertSubject -Message $alertMessage