[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "ClickUp"
    FileUrl       = "https://github.com/asheroto/ClickUp/releases/download/{VERSION}/ClickUp.exe"
    GitHubRepoUrl = "https://github.com/asheroto/ClickUp"
    AutoPush      = $true
    IgnoreVersion = '1.1.4'
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo