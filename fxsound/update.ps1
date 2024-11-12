[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

# Create a hash table to store package information
$packageInfo = @{
    PackageName         = "fxsound"
    FileUrl             = 'https://download.fxsound.com/fxsoundlatest'   # URL to download the file from
    FileDestinationPath = '.\tools\fxsound_setup.exe'                    # Path to move/rename the temporary file to (if EXE is distributed in package)
    AutoPush            = $true
    EnvFilePath         = "..\.env"
    IgnoreVersion       = "1.1.27"
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo