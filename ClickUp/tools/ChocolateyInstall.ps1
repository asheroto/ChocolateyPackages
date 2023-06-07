$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/1.0.0/ClickUp.exe'
$checksum       = '4622314B583781CD29D44B437CA1BEFA70A10075F2145B08DD6550B5E76AFA99'
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

# Stop the process
Stop-Process -Name $packageName -ErrorAction SilentlyContinue -Force

# Install the package
Install-ChocolateyPackage @packageArgs

Write-Output "---------------------------"
Write-Output ""
Write-Output "ClickUp has been installed and will automatically start when you log in."
Write-Output ""
Write-Output "Start it manually the first time by opening the ClickUp icon on your desktop."
Write-Output "Press Alt+F4 to close it to the system tray."
Write-Output "Press Alt+Esc at any time to bring it back to the foreground."
Write-Output ""
Write-Output "---------------------------"