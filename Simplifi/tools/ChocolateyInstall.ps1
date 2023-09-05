$ErrorActionPreference  = 'Stop'
$packageName    = 'Simplifi'
$softwareName   = 'Simplifi'
$url            = 'https://github.com/asheroto/Simplifi/releases/download/1.0.4/Simplifi.exe'
$checksum       = '9FBBE11144DB2C57DC39509D36569715981FB1C1F05C9AE1D38731F4B7717BBC'
$silentArgs     = '/quiet'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

# Install the package
Install-ChocolateyPackage @packageArgs

# Set the path, confirm it exists, start the process if it does
$SimplifiPath = Join-Path $env:APPDATA 'Simplifi\Simplifi.exe'
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