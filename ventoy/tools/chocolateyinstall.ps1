$ErrorActionPreference = "Stop";

# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── VentoyVlnk.exe
# └── other data

# Release URL: https://github.com/ventoy/Ventoy/releases
$packageName = "ventoy"
$version = "1.0.98" # Chocolatey package version may differ from the filename version
$url = "https://github.com/ventoy/Ventoy/releases/download/v${version}/${packageName}-${version}-windows.zip"
$checksum = "8A21ECED5EFEA22A82B2F8B2783A7DB2449C09EF0A4ECB0FA4D019E3AB06E0D1"

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

# Create shortcuts
# Each entry in the array has the format: [Shortcut Name, Target Executable, Additional Arguments, Desktop Shortcut Flag, Start Menu Shortcut Flag]
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

    # Check and Create Desktop shortcuts
    if (!$pp[$noDesktopShortcutFlag.ToLower()]) {
        $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$shortcutName.lnk"
        Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
    }

    # Check and Create Programs shortcuts
    if (!$pp[$noStartMenuShortcutFlag.ToLower()]) {
        $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$shortcutName.lnk"
        Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
    }
}