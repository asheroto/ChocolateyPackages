[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "httptoolkit"
    FileUrl       = "https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v{VERSION}/HttpToolkit-installer-{VERSION}.exe"
    GitHubRepoUrl = "https://github.com/httptoolkit/httptoolkit-desktop"
    AutoPush      = $true
    EnvFilePath   = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo