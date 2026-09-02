[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "nvm.install"
    FileUrl       = "https://github.com/nvm-windows/nvm/releases/download/v{VERSION}/nvm-{VERSION}-amd64-setup.exe"
    GitHubRepoUrl = "https://github.com/nvm-windows/nvm"
    AutoPush      = $true
    EnvFilePath   = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo