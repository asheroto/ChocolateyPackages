$ErrorActionPreference = 'Stop'

$packageName = 'ClickUp'
$softwareName = 'ClickUp'
$version = '1.1.5'
$url = "https://github.com/asheroto/ClickUp/releases/download/${VERSION}/ClickUp.exe"
$checksum = '577CFF9D5FA0A68A8238BE9AB3A174159C2DA0631F68B714D77BD13B56C43483'
$silentArgs = '/quiet'
$validExitCodes = @(0)

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    file           = $fileLocation
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = $softwareName
}

# Install the package
Install-ChocolateyPackage @packageArgs

# Set the path, confirm it exists, start the process if it does
$ClickUpPath = Join-Path $env:APPDATA 'ClickUp\ClickUp.exe'
if ((Test-Path $ClickUpPath)) { Start-Process $ClickUpPath -ArgumentList '-startup' }

Write-Output ""
Write-Output "---------------------------"
Write-Output ""
Write-Output "ClickUp has been installed and will automatically start when you log in."
Write-Output "It is currently running in the system tray."
Write-Output ""
Write-Output "Press Alt+Esc at any time to bring it to the foreground."
Write-Output "Press Alt+F4 to close it to the system tray."
Write-Output ""
Write-Output "---------------------------"
Write-Output ""