$ErrorActionPreference	= 'Stop';

$packageName 	= "iventoy"
$version 		= "1.0.11" # Chocolatey package version may differ from the filename version
$url 			= 'https://github.com/ventoy/PXE/releases/download/v1.0.11/iventoy-1.0.11-win32-free.zip'
$checksum 		= 'B442DEF627A9585C83141CE6DA5A7D961D6CEB948A1B8A2FF8DDAC05D14F1D01'
$url64 			= 'https://github.com/ventoy/PXE/releases/download/v1.0.11/iventoy-1.0.11-win64-free.zip'
$checksum64 	= '109C6A47B75D0A9DDAA4050CF40CF5F22978330E49BFF18EC461F4C4964FEE73'
$unzipLocation 	= Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

$packageArgs = @{
	packageName    = $packageName
	unzipLocation  = $unzipLocation
	fileType       = 'ZIP'
	url            = $url
	checksum       = $checksum
	checksumType   = 'sha256'
	url64          = $url64
	checksum64     = $checksum64
	checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Copy all files/folders from the iventoy-$version folder to the unzipLocation
Copy-Item -Path "$unzipLocation\iventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\iventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
	, @('iVentoy', 'iVentoy_32.exe')
	, @('iVentoy', 'iVentoy_64.exe')
	, @('iVentoy ISOs', 'iso')
) | ForEach-Object {
	$targetPath = Join-Path $unzipLocation $_[1]

	# Create Programs shortcuts
	$programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"

	# If the $targetPath exists, create a shortcut
	if (Test-Path $targetPath) {
		Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
	}

	# Create Desktop shortcuts
	$desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"

	# If the $targetPath exists, create a shortcut
	if (Test-Path $targetPath) {
		Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
	}
}