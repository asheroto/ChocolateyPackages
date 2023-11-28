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
    version       = '1.1.12'
    url           = "https://github.com/coreybutler/nvm-windows/releases/download/1.1.12/nvm-setup.zip"
    checksum      = '4E076C1B80DBC97A21DA75792CC35F292247C034DAA698044FED30A00020AD6F'
    checksumType  = 'sha256'
    unzipLocation = $toolsDir
}

# Install the package
Install-ChocolateyZipPackage @packageArgs

# Create ignore file for setup executable
New-Item -Path "$toolsDir\nvm-setup.exe.ignore" -ItemType File

# Start installation process
Start-Process "$toolsDir\nvm-setup.exe" -ArgumentList "/VERYSILENT /NOCIONS /DIR=$nvmPath"