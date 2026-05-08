$ErrorActionPreference = 'Stop'

$packageName = 'ClickUp'
$version = '1.1.7'
$url = "https://github.com/asheroto/ClickUp/releases/download/$version/ClickUp.exe"
$checksum = '9F6BEBA1D811536ED742EE63C37746973A02E5D7E1EF62B088EFDBF4F417C895'
$silentArgs = '/quiet'
$validExitCodes = @(0)

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
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