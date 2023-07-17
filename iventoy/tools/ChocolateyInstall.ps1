$ErrorActionPreference	= 'Stop';

$packageName 	= "iventoy"
$version 		= "1.0.12" # Chocolatey package version may differ from the filename version
$url 			= 'https://github.com/ventoy/PXE/releases/download/v1.0.12/iventoy-1.0.12-win32-free.zip'
$checksum 		= 'A0C815631D00D82F720D7330CCDDA50EEBF0508B49873623E81A9DE5CD0CD5F6'
$url64 			= 'https://github.com/ventoy/PXE/releases/download/v1.0.12/iventoy-1.0.12-win64-free.zip'
$checksum64 	= '15D3C9A661CC61A5104BEEEBA1D012C45D8841DDE30E780EB2A03443164E0E10'
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