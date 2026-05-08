$ErrorActionPreference = 'Stop'

$packageName = 'MessagesForWeb'
$version = '1.0.5'
$url = "https://github.com/asheroto/MessagesForWeb/releases/download/$version/MessagesForWeb.exe"
$checksum = '8724D32B8B1B949F1BACE1E7BBE0FEE55A0DED2C46FAAC317FB17C98EEB79BEC'
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