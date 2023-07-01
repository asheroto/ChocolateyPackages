# exe location
# └── iVentoy_64.exe
# └── iso
# └── other data

$ErrorActionPreference	= 'Stop';

$packageName = "iventoy"
$version = "1.0.06" # Chocolatey package version may differ from the filename version
$fileName = "$packageName-$version-win64.zip"
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$file = Join-Path $toolsDir $fileName
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

$packageArgs = @{
	packageName   = $packageName
	unzipLocation = $unzipLocation
	file          = $file
}

Install-ChocolateyZipPackage @packageArgs

# Keeping this logic as is - was from original maintainer script
Copy-Item -Path "$unzipLocation\iventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\iventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
	, @('iVentoy', 'iVentoy_64.exe')
	, @('iVentoy ISOs', 'iso')
) | ForEach-Object {
	$targetPath = Join-Path $unzipLocation $_[1]

	# Create Programs shortcuts
	$programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation

	# Create Desktop shortcuts
	$desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
	Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
}