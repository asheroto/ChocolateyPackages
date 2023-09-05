$ErrorActionPreference = 'Stop'
# Download URL: https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install

# Package vars
$ChocoPackage = @{
    packageName    = 'Windows Assessment and Deployment Kit - User State Migration Tool'
    url            = 'https://go.microsoft.com/fwlink/?linkid=2196127'
    checksum256    = 'FEA28F693139CDB55D2C993273B815147F804BB27BCB912F85ABAFC63FC6AAC8'
    silentArgs     = "/quiet /norestart /log $env:temp\win_adk_usmt.log /features OptionId.UserStateMigrationTool"
    fileType       = 'exe'
    validExitCodes = @(0, 3010)
}

# Install package
Install-ChocolateyPackage @ChocoPackage

#####################################################################################################################
# scanstate/loadstate won't work unless you run them from the directory they're in since XML files are referenced
#####################################################################################################################

# Import the functions from the Functions.ps1 file
. "$PSScriptRoot\Functions.ps1"

# Set up USMTPath environment variable
$usmtPath = Get-USMTPath
if ($null -ne $usmtPath) {
    Set-EnvironmentVariable -Name 'USMTPath' -Value $usmtPath -Target 'Machine'
    Update-SessionEnvironment
}

#######################################
# How to use the User State Migration Tool (USMT)
#######################################
Write-Section "How to use the User State Migration Tool (USMT)"
Write-Warning "To use this package you must first change directories to the USMT directory because scanstate/loadstate won't work unless you run them from the directory they're in since XML files are referenced.`n`nTo change directories quickly, type `"cd `$ENV:USMTPath`" and press Enter. Then you can run scanstate/loadstate commands below.`n"
Write-Output ".\ScanState C:\MigrationStore /i:MigApp.xml /i:MigUser.xml /o /v:13 /l:ScanState.log"
Write-Output "`tC:\MigrationStore: The path where migration files will be stored. Data is copied here.`n`t/i:MigApp.xml /i:MigUser.xml: Includes the standard migration rule files.`n`t/o: Overwrites the output location if it exists.`n`t/v:13: Sets the verbosity level for logging.`n`t/l:ScanState.log: Specifies the log file.`n"
Write-Output ".\LoadState C:\MigrationStore /i:MigApp.xml /i:MigUser.xml /v:13 /l:LoadState.log /lac"
Write-Output "`tC:\MigrationStore: The path where migration files are located.`n`t/i:MigApp.xml /i:MigUser.xml: Includes the standard migration rule files.`n`t/v:13: Sets the verbosity level for logging.`n`t/l:LoadState.log: Specifies the log file.`n`t/lac: Specifies that local accounts should be created if they do not exist on the destination computer.`n"
Write-Output "More info: .\ScanState /? or .\LoadState /?"
Write-Output "Documentation: https://learn.microsoft.com/en-us/windows/deployment/usmt/usmt-command-line-syntax`n"