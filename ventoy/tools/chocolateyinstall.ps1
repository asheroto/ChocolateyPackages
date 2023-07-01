# exe location
# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── other data

$ErrorActionPreference = 'Stop';
$packageName = "ventoy"
$version = "1.0.93" # Chocolatey package version may differ from the filename version
$fileName = "$packageName-$version-windows.zip"
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$file = Join-Path $toolsDir $fileName
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

$packageArgs = @{
	packageName = $packageName
	unzipLocation = $unzipLocation
	file = $file
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