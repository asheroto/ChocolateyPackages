$ErrorActionPreference = "Stop";

# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── other data

# Release URL: https://github.com/ventoy/Ventoy/releases
$packageName    = "ventoy"
$version        = "1.0.95" # Chocolatey package version may differ from the filename version
$url            = "https://github.com/ventoy/Ventoy/releases/download/v$($version)/$($packageName)-$($version)-windows.zip"
$checksum       = "73EB20D1C17B068F0D6315304AFFC5CBF7102DE8699FC4E0B620ABB3EBBC0D4C"
$unzipLocation  = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

$packageArgs = @{
	packageName    = $packageName
	unzipLocation  = $unzipLocation
	fileType       = "ZIP"
	url            = $url
	checksum       = $checksum
	checksumType   = "sha256"
}

# Install Ventoy zip package
Install-ChocolateyZipPackage @packageArgs

# Copy Ventoy.exe and Ventoy2Disk.exe to unzipLocation
Copy-Item -Path "$unzipLocation\ventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\ventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
	,@('Ventoy', 'Ventoy2Disk.exe')
	,@('Ventoy Plugson', 'VentoyPlugson.exe')
) | ForEach-Object {
	$targetPath = Join-Path $unzipLocation $_[1]

	# Create Programs shortcuts
	$programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation

	# Create Desktop shortcuts
	$desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
	Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
}