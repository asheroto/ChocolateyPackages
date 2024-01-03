$ErrorActionPreference = 'Stop'

# https://www.lopesoft.com/fmtools/FileMenuTools-setup.exe

# Package args
$packageArgs = @{
    packageName    = 'filemenutools'
    fileType       = 'exe'
    file           = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\FileMenuTools-setup.exe"
    checksum       = '231E2F131B7A7B448D0968AB6D16E2E90F8F370DD2E921BD6B9CE12CFB42C5E7'
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