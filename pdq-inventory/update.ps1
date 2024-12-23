[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName         = "pdq-inventory"                                               # Package name
    FileUrl             = "http://www2.adminarsenal.com/download-pdqinventory"          # URL to download the file from
    FileDestinationPath = '.\tools\PDQ_Inventory_Setup.exe'                             # Path to move/rename the temporary file to (if EXE is distributed in package)
    AutoPush            = $true
    EnvFilePath         = "..\.env"
    IgnoreVersion       = "19.3.626"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo