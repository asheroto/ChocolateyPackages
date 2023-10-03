[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "StartAllBack"                                                                                  # Package name
    ScrapeUrl     = 'https://startallback.com/'                                                                     # URL to scrape for version number
    ScrapePattern = '(?<=<span class="title">Download v)[\d.]+'                                                     # Regex pattern to match version number
    FileUrl       = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_{VERSION}_setup.exe"          # URL to download the file from
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo