[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "recuva"                                                                                        # Package name
    ScrapeUrl     = 'https://www.ccleaner.com/recuva/release-notes'                                                 # URL to scrape for version number
    ScrapePattern = '(?<=<h6>v)[\d.]+'                                                                              # Regex pattern to match version number
    FileUrl       = "https://download.ccleaner.com/rcsetup153.exe"                                                  # URL to download the file from
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo
#test