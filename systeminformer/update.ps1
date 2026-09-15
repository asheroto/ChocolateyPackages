[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path ($ScriptPath MUST be defined for the UpdateChocolateyPackage function to work)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
# Tracks stable releases on winsiderss/systeminformer (what systeminformer.com/downloads links to), not the canary builds on winsiderss/si-builds
# ponytail: assumes the asset name uses the full tag version; 3.2.25011 broke this (tag 3.2.25011.2103), in which case the download 404s and an error alert is sent
$packageInfo = @{
    PackageName   = 'systeminformer'
    GitHubRepoUrl = 'https://github.com/winsiderss/systeminformer'
    FileUrl       = 'https://github.com/winsiderss/systeminformer/releases/download/v{VERSION}/systeminformer-{VERSION}-release-setup.exe'
    AutoPush      = $true
    EnvFilePath   = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo
