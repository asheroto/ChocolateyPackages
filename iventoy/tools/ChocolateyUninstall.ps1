﻿$ErrorActionPreference	= 'Stop';

$unzipPath = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) ([Environment]::GetEnvironmentVariable("ChocolateyPackageName"))

@(
	, @('iVentoy', 'iVentoy_64.exe')
	, @('iVentoy ISOs', 'iso')
) | ForEach-Object {
	# Remove Programs shortcuts
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue

	# Remove Desktop shortcuts
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
	Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
}

if (Test-Path $unzipPath) {
	# Remove all files/folders except the iso folder
	Get-ChildItem -Path $unzipPath | Where-Object { $_.Name -ne "iso" } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}