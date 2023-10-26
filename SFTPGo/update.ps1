# Set vars to the script and the parent path ($ScriptPath MUST be defined for the UpdateChocolateyPackage function to work)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "sftpgo"
    FileUrl       = "https://github.com/drakkan/sftpgo/releases/download/v{VERSION}/sftpgo_v{VERSION}_windows_x86_64.exe"
    GitHubRepoUrl = "https://github.com/drakkan/sftpgo"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo