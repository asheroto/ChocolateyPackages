$ErrorActionPreference = "Stop";

# Typical location: C:\ProgramData\chocolatey\lib\ventoy\altexe
# ventoy-$version
# └── other data files
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── VentoyVlnk.exe
# └── altexe
# └──── Ventoy2Disk_X64.exe
# └──── Ventoy2Disk_ARM.exe
# └──── Ventoy2Disk_ARM64.exe
# └──── VentoyPlugson_X64.exe

# Release URL: https://github.com/ventoy/Ventoy/releases
$packageName = "ventoy"
$version = "" # Chocolatey package version may differ from the filename version
$url = "https://github.com/ventoy/Ventoy/releases/download/v${version}/${packageName}-${version}-windows.zip"
$checksum = "3E7A8DB199C7E791E341E6D388D078BFC6B7A77C6F10282EDF9C7B82F84F3AD4"

# Remove Ventoy directory in old location if it exists (local app data) - implemented April 2024
$oldUnzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName
if (Test-Path $oldUnzipLocation) {
	Remove-Item -Path $oldUnzipLocation -Recurse -Force -ErrorAction SilentlyContinue
}

# Set new install location to ChocolateyInstall\lib\ventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

$packageArgs = @{
	packageName   = $packageName
	unzipLocation = $unzipLocation
	fileType      = "ZIP"
	url           = $url
	checksum      = $checksum
	checksumType  = "sha256"
}

# Install Ventoy zip package
Install-ChocolateyZipPackage @packageArgs

# Define the path to the version-specific Ventoy directory
$ventoyVersionPath = [System.IO.Path]::Combine($unzipLocation, "ventoy-$version")

# Copy all items from ventoy-$version directory to the unzipLocation
Copy-Item -Path "$ventoyVersionPath\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue

# Remove the version-specific Ventoy directory after copying its contents
Remove-Item -Path $ventoyVersionPath -Force -Recurse -ErrorAction SilentlyContinue

# Parse package parameters
$pp = Get-PackageParameters

# Define the start menu folder
$startMenuFolder = Join-Path ([Environment]::GetFolderPath("Programs")) "Ventoy"

# Ensure the start menu folder exists
if (-not (Test-Path $startMenuFolder)) {
	New-Item -Path $startMenuFolder -ItemType Directory | Out-Null
}

# Move existing Ventoy shortcuts to the start menu folder
Get-ChildItem -Path ([Environment]::GetFolderPath("Programs")) -Filter "Ventoy*.lnk" | ForEach-Object {
	Move-Item -Path $_.FullName -Destination $startMenuFolder -Force -ErrorAction SilentlyContinue
}

# Create shortcuts for default executables
@(
	, @('Ventoy', 'Ventoy2Disk.exe', '', 'NoDesktopShortcutVentoy', 'NoStartMenuShortcutVentoy')
	, @('Ventoy Plugson', 'VentoyPlugson.exe', '', 'NoDesktopShortcutVentoyPlugson', 'NoStartMenuShortcutVentoyPlugson')
	, @('Ventoy Vlnk', 'VentoyVlnk.exe', '-s', 'NoDesktopShortcutVentoyVlnk', 'NoStartMenuShortcutVentoyVlnk')
) | ForEach-Object {
	# Assigning values to variables for clarity
	$shortcutName = $_[0]
	$executableName = $_[1]
	$additionalArguments = $_[2]
	$noDesktopShortcutFlag = $_[3].ToLower()
	$noStartMenuShortcutFlag = $_[4].ToLower()

	$targetPath = Join-Path $unzipLocation $executableName

	# Check and create Desktop shortcuts
	if (!$pp[$noDesktopShortcutFlag.ToLower()]) {
		$desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$shortcutName.lnk"
		Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
	}

	# Check and create Start Menu shortcuts
	if (!$pp[$noStartMenuShortcutFlag.ToLower()]) {
		$programsShortcutPath = Join-Path $startMenuFolder "$shortcutName.lnk"
		Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
	}
}

# Create shortcuts for altexe executables if specified
@(
	, @('Ventoy x64', 'altexe\Ventoy2Disk_X64.exe', '', 'CreateDesktopShortcutVentoyX64', 'CreateStartMenuShortcutVentoyX64')
	, @('Ventoy Plugson x64', 'altexe\VentoyPlugson_X64.exe', '', 'CreateDesktopShortcutVentoyPlugsonX64', 'CreateStartMenuShortcutVentoyPlugsonX64')
	, @('Ventoy ARM', 'altexe\Ventoy2Disk_ARM.exe', '', 'CreateDesktopShortcutVentoyARM', 'CreateStartMenuShortcutVentoyARM')
	, @('Ventoy ARM64', 'altexe\Ventoy2Disk_ARM64.exe', '', 'CreateDesktopShortcutVentoyARM64', 'CreateStartMenuShortcutVentoyARM64')
) | ForEach-Object {
	# Assigning values to variables for clarity
	$shortcutName = $_[0]
	$executableName = $_[1]
	$additionalArguments = $_[2]
	$createDesktopShortcutFlag = $_[3].ToLower()
	$createStartMenuShortcutFlag = $_[4].ToLower()

	$targetPath = Join-Path $unzipLocation $executableName

	# Check and create Desktop shortcuts if specified
	if ($pp[$createDesktopShortcutFlag.ToLower()]) {
		$desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$shortcutName.lnk"
		Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
	}

	# Check and create Start Menu shortcuts if specified
	if ($pp[$createStartMenuShortcutFlag.ToLower()]) {
		$programsShortcutPath = Join-Path $startMenuFolder "$shortcutName.lnk"
		Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
	}
}
