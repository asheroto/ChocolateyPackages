$ErrorActionPreference	= 'Stop';

$unzipPath = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) ([Environment]::GetEnvironmentVariable("ChocolateyPackageName"))

@(
	,@('Ventoy', 'Ventoy2Disk.exe')
	,@('Ventoy Plugson', 'VentoyPlugson.exe')
) | ForEach-Object {
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
}

if (Test-Path $unzipPath) {
	Remove-Item -Path $unzipPath -Recurse -Force -ErrorAction SilentlyContinue
}