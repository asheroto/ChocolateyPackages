$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$softwareName = 'Messages for Web'
$version = '1.0.4'
$url = "https://github.com/asheroto/MessagesForWeb/releases/download/${version}/MessagesForWeb.exe"
$checksum = 'BBE771B74EDE62BB0E119A4949A698EC6E92377F4419B5F9F51521D8C9E23F8D'
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