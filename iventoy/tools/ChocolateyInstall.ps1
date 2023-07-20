$ErrorActionPreference	= "Stop";

# Release URL: https://github.com/ventoy/PXE/releases
$packageName    = "iventoy"
$version        = "1.0.16" # Chocolatey package version may differ from the filename version
$url            = "https://github.com/ventoy/PXE/releases/download/v$($version)/iventoy-$($version)-win32-free.zip"
$checksum       = "36B160AA1D4AF84D7C9CACD122002B06C19FB9C8B2AF89985CBE1F6803EF7A86"
$url64          = "https://github.com/ventoy/PXE/releases/download/v$($version)/iventoy-$($version)-win64-free.zip";
$checksum64     = "24227B40B838F2C6C144046534FB46823971BBB2856C931B7C1AB01A5750D4F1"
$unzipLocation  = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

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