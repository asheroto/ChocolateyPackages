$ErrorActionPreference = 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package args
$packageArgs = @{
    packageName    = 'filemenutools'
    fileType       = 'exe'
    file           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\FileMenuTools-setup.exe"
    checksum       = '3B00371D46783DBE3B335F56A6C16E309663F3983BE2AE7619D083DB91742EC0'
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