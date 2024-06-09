$ErrorActionPreference = 'Stop'
$packageName = 'Simplifi'
$softwareName = 'Simplifi'
$version = "1.0.5"
$url = "https://github.com/asheroto/Simplifi/releases/download/${version}/Simplifi.exe"
$checksum = '5EA43865E45D83D07906F66F1CF4EE53F8F3AEEB106D125AA3A12F288B5EAC1D'
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
$SimplifiPath = [System.IO.Path]::Combine($env:APPDATA, 'Simplifi', 'Simplifi.exe')
if ((Test-Path $SimplifiPath)) { Start-Process $SimplifiPath -ArgumentList '-startup' }

Write-Output ""
Write-Output "---------------------------"
Write-Output ""
Write-Output "Simplifi has been installed and will automatically start when you log in."
Write-Output "It is currently running in the system tray."
Write-Output ""
Write-Output "Press Ctrl+Alt+I at any time to bring it back to the foreground."
Write-Output "Press Alt+F4 to close it to the system tray."
Write-Output ""
Write-Output "---------------------------"
Write-Output ""