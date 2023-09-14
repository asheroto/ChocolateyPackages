$ErrorActionPreference	= "Stop";

# Release URL: https://github.com/ventoy/PXE/releases
$packageName    = "iventoy"
$version        = "1.0.19" # Chocolatey package version may differ from the filename version
$url            = "https://github.com/ventoy/PXE/releases/download/v$($version)/iventoy-$($version)-win32-free.zip"
$checksum       = "DD9F2EF2BC51E64D88CEBAF821BB4EE0B716436D4FAB44E58DEBFF9E4FB4373C"
$url64          = "https://github.com/ventoy/PXE/releases/download/v$($version)/iventoy-$($version)-win64-free.zip";
$checksum64     = "E23720F6BD4FDBA4F08A013C88324DF89DF06047C17538B0E2775B52920BD86B"
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