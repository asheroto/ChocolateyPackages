[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "TablePlus"                                                                                     # Package name
    ScrapeUrl     = 'https://tableplus.com/blog/2018/09/changelogs-windows.html'                                    # URL to scrape for version number
    ScrapePattern = '(?<=TablePlus\s)[\d.]+(?=\s-\sBuild)'                                                         # Regex pattern to match version number
    FileUrl       = "https://download.tableplus.com/windows/{VERSION}/TablePlusSetup.exe"                           # URL to download the file from
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo