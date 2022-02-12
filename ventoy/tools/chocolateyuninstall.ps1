$ErrorActionPreference	= 'Stop';

$shortcutsPath = Join-Path ([Environment]::GetFolderPath("Programs")) 'Ventoy.lnk'
$unzipPath = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) ([Environment]::GetEnvironmentVariable("ChocolateyPackageName"))

Remove-Item -Path $shortcutsPath -ErrorAction SilentlyContinue

if (Test-Path $unzipPath) { 
	Remove-Item -Path $unzipPath -Recurse -Force -ErrorAction SilentlyContinue
}