# Set error action preference to stop on errors
$ErrorActionPreference = 'Stop'

# Define package name and tool directory
$packageName = $env:chocolateyPackageName
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$nvmPath = Join-Path $env:ProgramData 'nvm'

# Package arguments for installation
$packageArgs = @{
    packageName   = $packageName
    fileType      = 'zip'
    version       = '1.2.2'
    url           = "https://github.com/coreybutler/nvm-windows/releases/download/1.2.2/nvm-setup.zip"
    checksum      = '5AB9927FB41206614CBD1BF2F387FB8A074CAF3ED35E27DE16CCDCD0A4D95DBE'
    checksumType  = 'sha256'
    unzipLocation = $toolsDir
}

# Install the package
Install-ChocolateyZipPackage @packageArgs

# Create ignore file for setup executable
New-Item -Path "$toolsDir\nvm-setup.exe.ignore" -ItemType File

# Start installation process
Start-Process "$toolsDir\nvm-setup.exe" -ArgumentList "/VERYSILENT /NOCIONS /DIR=$nvmPath"