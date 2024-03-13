$ErrorActionPreference = 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package args
$packageArgs = @{
    packageName    = 'filemenutools'
    fileType       = 'exe'
    file           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\FileMenuTools-setup.exe"
    checksum       = '5495C36A838BB25E3342081BB4F6DB5E910B48B849D7DB82110FFED86A1D253B'
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