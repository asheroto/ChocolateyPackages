# Disable for now as the website has changed significantly
# Switched to VisualPing to monitor changes

<# [CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "recuva"
    ScrapeUrl     = 'https://www.ccleaner.com/recuva/release-notes'
    ScrapePattern = '(?<=<strong>Patch update )[\d.]+'
    FileUrl       = "https://download.ccleaner.com/rcsetup153.exe"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo #>