[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path ($ScriptPath MUST be defined for the UpdateChocolateyPackage function to work)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName   = "laravel-herd"
    ScrapeUrl     = 'https://herd.laravel.com/changelog'
    ScrapePattern = '(?<=<div class="cursor-pointer[^>]*?>)[\d.]+(?=</div>)'
    FileUrl       = "https://download.herdphp.com/app_versions/Herd-{VERSION}-setup.exe"
    AutoPush      = $true
    EnvFilePath   = "..\.env"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo