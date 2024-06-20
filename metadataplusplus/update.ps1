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
    ScrapeUrl                = 'https://logipole.com/download-en.htm'               # URL to scrape for version number
    ScrapePattern            = '(?<=Metadata\+\+ v )[\d.]+(?=</b>)'                 # Regex pattern to match version number
    DownloadUrlScrapePattern = '(?<=<a href=")[^"]*metadata\+\+-[\d-]+\.exe(?=")'   # Updated regex pattern to find download URL
    FileUrl                  = 'SCRAPE'                                             # Set to SCRAPE if using DownloadUrlScrapePattern
    AutoPush                 = $true
    EnvFilePath              = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo