[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "iventoy"
    GitHubRepoUrl = 'https://github.com/ventoy/PXE'
    FileUrl       = 'https://github.com/ventoy/PXE/releases/download/v{VERSION}/iventoy-{VERSION}-win32-free.zip'
    FileUrl64     = 'https://github.com/ventoy/PXE/releases/download/v{VERSION}/iventoy-{VERSION}-win64-free.zip'
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo