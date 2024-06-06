$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$softwareName = 'Messages for Web'
$url = 'https://github.com/asheroto/MessagesForWeb/releases/download/1.0.1/MessagesForWeb.exe'
$checksum = '7CFA3EA4137E89F8C17F4E69E31A9475255A4BCBA7F7D4C1F08ACEC5DDF3DC4C'
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
$MessagesForWebPath = [System.IO.Path]::Combine($env:APPDATA, 'MessagesForWeb', 'MessagesForWeb.exe')
if ((Test-Path $MessagesForWebPath)) { Start-Process $MessagesForWebPath -ArgumentList '-startup' }

Write-Output ""
Write-Output "---------------------------"
Write-Output ""
Write-Output "MessagesForWeb has been installed and will automatically start when you log in."
Write-Output "It is currently running in the system tray."
Write-Output ""
Write-Output "Press Ctrl+Alt+M at any time to bring it back to the foreground."
Write-Output "Press Alt+F4 to close it to the system tray."
Write-Output ""
Write-Output "---------------------------"
Write-Output ""