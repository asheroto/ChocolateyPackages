[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "chatgpt"
    GitHubRepoUrl = 'https://github.com/lencx/ChatGPT'
    FileUrl       = 'https://github.com/lencx/ChatGPT/releases/download/v{version}/ChatGPT_{version}_windows_x86_64.msi'
    IgnoreVersion = "1.1.0"
    AutoPush      = $true
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo