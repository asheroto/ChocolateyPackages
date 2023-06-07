$packageName = 'ClickUp'
$softwareName = 'ClickUp'
$url = 'https://github.com/asheroto/ClickUp/releases/download/1.1.2/ClickUp.exe'
$checksum = 'B5C8C4558601098FED5169A4511E97B66B099CB4CA484E64875481B2B2360E3A'
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
Write-Output "Press Alt+F4 to close it to the system tray."
Write-Output "Press Alt+Esc at any time to bring it back to the foreground."
Write-Output ""
Write-Output "---------------------------"
Write-Output ""