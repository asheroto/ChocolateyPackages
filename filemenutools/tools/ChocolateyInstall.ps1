$ErrorActionPreference = 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package args
$packageArgs = @{
    packageName    = 'filemenutools'
    fileType       = 'exe'
    file           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\FileMenuTools-setup.exe"
    checksum       = 'CA56621E57456CA2B4D948C004B567871294953EC8B518D0B1B28517AECD9C8E'
    checksumType   = 'sha256'
    silentArgs     = '/VERYSILENT /NORESTART'
    validExitCodes = @(0)
    softwareName   = 'FileMenu Tools*'
}

# Install
Install-ChocolateyInstallPackage @packageArgs

# Output to user
Write-Output "---------------------------"
Write-Output ""
Write-Output "You may need to restart your computer in order for FileMenu Tools to work as expected."
Write-Output ""
Write-Output "---------------------------"