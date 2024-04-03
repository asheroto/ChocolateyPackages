[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path ($ScriptPath MUST be defined for the UpdateChocolateyPackage function to work)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "laravel-herd"                                                                                  # Package name
    ScrapeUrl     = 'https://herd.laravel.com/changelog'                                                            # URL to scrape for version number
    ScrapePattern = '(?<=<h3 class="pl-6 md:pl-0">)[\d.]+(?=</h3>)'                                                 # Regex pattern to scrape for version number
    FileUrl       = "https://download.herdphp.com/app_versions/Herd-{VERSION}-setup.exe"                            # URL to download the file from
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo