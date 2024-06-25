$ErrorActionPreference = 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package args
$packageArgs = @{
    packageName    = 'filemenutools'
    fileType       = 'exe'
    file           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\FileMenuTools-setup.exe"
    checksum       = '735C04BE67EAB98355613B6F41282CF6D4B1C560687BD2D5A5C95E9464F1EA54'
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
