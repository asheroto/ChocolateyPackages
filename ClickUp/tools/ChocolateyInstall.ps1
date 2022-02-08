$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.5.0/ClickUp.exe'
$checksum       = '9E072FC93EDC3A0A6F0A99AD483BE6F1DF4C90458F69A1D7364234D3620D831E'
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
Stop-Process -Name $packageName -ErrorAction SilentlyContinue

# Install the package
Install-ChocolateyPackage @packageArgs

# Start the process
$ClickUpPath = Join-Path -Path (Get-InstallRegistryKey ClickUp).InstallLocation -ChildPath "ClickUp.exe"
$ClickUpSilentArgs = "-startup"
Start-Process -FilePath $ClickUpPath -ArgumentList $ClickUpSilentArgs

# `t = tab
Write-Output $("-" * 25)
Write-Output ""
Write-Output "ClickUp is now running from the system tray. Press Alt-Esc to activate it."
Write-Output "ClickUp is installed and will automatically start on Windows login."
Write-Output ""
Write-Output $("-" * 25)