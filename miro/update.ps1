[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName = "miro"
    FileUrl     = 'https://desktop.miro.com/platforms/win32-x86/Miro.exe'   # URL to download the file from
    FileUrl64   = 'https://desktop.miro.com/platforms/win32/Miro.exe'       # URL to download the file from
    Alert       = $true                                                     # If the package is updated, send a message to the maintainer for review
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo