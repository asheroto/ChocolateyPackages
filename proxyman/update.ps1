[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "proxyman"
    FileUrl       = "https://github.com/ProxymanApp/proxyman-windows-linux/releases/download/{VERSION}/Proxyman.Setup.{VERSION}.exe"
    GitHubRepoUrl = "https://github.com/ProxymanApp/proxyman-windows-linux"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo