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
    # We are intentionally ahead of the latest STABLE release on a prerelease build
    # (package 2.0.1-hotfix0001, from upstream 2.0.1-hotfix.1). The updater reads GitHub's
    # latest stable release, which is 2.0.0, so ignore 2.0.0 to avoid overwriting the hotfix
    # build. Clear this once stable 2.0.1 ships so the updater picks it up.
    IgnoreVersion = "2.0.0"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo