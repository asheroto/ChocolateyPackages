$ErrorActionPreference	= "Stop";

$packageName = "iventoy"

# Set new install location to ChocolateyInstall\lib\iventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

@(
	, @('iVentoy', 'iVentoy_32.exe')
	, @('iVentoy', 'iVentoy_64.exe')
	, @('iVentoy ISOs', 'iso')
) | ForEach-Object {
	# Remove Programs shortcuts
	$targetPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"

	# If the $targetPath exists, remove the shortcut
	if (Test-Path $targetPath) {
		Remove-Item -Path $targetPath -ErrorAction SilentlyContinue
	}

	# Remove Desktop shortcuts
	$targetPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"

	# If the $targetPath exists, remove the shortcut
	if (Test-Path $targetPath) {
		Remove-Item -Path $targetPath -ErrorAction SilentlyContinue
	}
}

if (Test-Path $unzipLocation) {
	# Remove all files/folders except the iso folder
	Get-ChildItem -Path $unzipLocation | Where-Object { $_.Name -ne "iso" } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}