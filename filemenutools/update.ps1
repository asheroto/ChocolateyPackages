[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName          = "filemenutools"
    FileUrl              = 'https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe'
    FileDestinationPath  = '.\tools\FileMenuTools-setup.exe'
    AutoPush             = $true
    EnvFilePath         = "..\.env"
    IgnoreVersion       = "8.4.2"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo