[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName              = "metadataplusplus"
    ScrapeUrl                = 'https://logipole.com/download.htm'               # URL to scrape for version number
    ScrapePattern            = '(?<=<h2>Metadata\+\+ )[\d.]+(?=</h2>)'              # First <h2> is the "Latest version" card
    DownloadUrlScrapePattern = 'https?://[^"]*metadata\+\+-[\d-]+\.exe'             # First matching href is the latest version
    FileUrl                  = 'SCRAPE'                                             # Set to SCRAPE if using DownloadUrlScrapePattern
    AutoPush                 = $true
    EnvFilePath              = "..\.env"
    IgnoreVersion            = '3.0.1.20260727'
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo