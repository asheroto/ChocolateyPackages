[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "speedtest"                                                                                     # Package name
    ScrapeUrl     = 'https://www.speedtest.net/apps/cli'                                                            # URL to scrape for version number
    ScrapePattern = '(?<=ookla-speedtest-)[\d.]+(?=-win64\.zip)'                                                    # Regex pattern to match version number
    FileUrl       = "https://install.speedtest.net/app/cli/ookla-speedtest-{VERSION}-win64.zip"                     # URL to download the file from
    AutoPush      = $true
    EnvFilePath   = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo