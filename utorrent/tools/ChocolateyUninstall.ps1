# Define vars
$ErrorActionPreference 	= "Stop"
$packageName    		= "utorrent"
$fileType				= "exe"
$silentArgs     		= "/uninstall /S"
$validExitCodes 		= @(0, 3010, 1605, 1614, 1641)
$uTorrentPath 			= "$env:APPDATA\uTorrent\uTorrent.exe"

# Define package args
$packageArgs = @{
	packageName    = $packageName
	file           = $uTorrentPath
	fileType       = $fileType
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
}

# Uninstall uTorrent
Uninstall-ChocolateyPackage @packageArgs