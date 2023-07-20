$ErrorActionPreference = "Stop";

$packageName   = "ventoy"
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

@(
	,@('Ventoy', 'Ventoy2Disk.exe')
	,@('Ventoy Plugson', 'VentoyPlugson.exe')
) | ForEach-Object {
	# Remove Programs shortcuts
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue

	# Remove Desktop shortcuts
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
	Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
}

if (Test-Path $unzipLocation) {
	Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue
}