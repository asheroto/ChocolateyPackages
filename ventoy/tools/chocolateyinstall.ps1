# exe location
# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── other data

$ErrorActionPreference	= 'Stop';
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

Install-ChocolateyZipPackage @packageArgs

# Keeping this logic as is - was from original maintainer script
Copy-Item -Path "$unzipLocation\ventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\ventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
	,@('Ventoy', 'Ventoy2Disk.exe')
	,@('Ventoy Plugson', 'VentoyPlugson.exe')
) | ForEach-Object {
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	$exePath = Join-Path $unzipLocation $_[1]
	Install-ChocolateyShortcut `
		-ShortcutFilePath $shortcutPath `
		-Target $exePath `
		-WorkingDirectory $unzipLocation
}