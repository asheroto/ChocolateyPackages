[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Use PowerShell 7+ to run this script

# Remember current directory
Push-Location

# Change to the directory of this script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath

# Imports the Chocolatey-Package-Updater functions
. ..\Chocolatey-Package-Updater.ps1

# Create a hash table to store package information
$packageInfo = @{
    PackageName          = "filemenutools"
    FileUrl              = 'https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe'    # URL to download the file from
    FileDestinationPath  = '.\tools\FileMenuTools-setup.exe'                             # Path to move/rename the temporary file to (if EXE is distributed in package)
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo

# Return to the original directory
Pop-Location