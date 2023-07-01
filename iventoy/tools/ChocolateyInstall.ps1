# exe location
# iventoy-$version

$ErrorActionPreference	= 'Stop';
$packageName = "iventoy"
$fileName = "iventoy-1.0.06-win64.zip"
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$file = Join-Path $toolsDir $fileName
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName
$version = [Environment]::GetEnvironmentVariable("ChocolateyPackageVersion")

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
	, @('iVentoy', 'iVentoy_64.exe'),
	, @('iVentoy ISOs', 'iso')
) | ForEach-Object {
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	$targetPath = Join-Path $unzipLocation $_[1]
	Install-ChocolateyShortcut `
		-ShortcutFilePath $shortcutPath `
		-Target $targetPath `
		-WorkingDirectory $unzipLocation
}