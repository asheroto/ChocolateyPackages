$ErrorActionPreference = "Stop";

# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── VentoyVlnk.exe
# └── other data

# Release URL: https://github.com/ventoy/Ventoy/releases
$packageName = "ventoy"
$version = "1.0.97" # Chocolatey package version may differ from the filename version
$url = "https://github.com/ventoy/Ventoy/releases/download/v${version}/${packageName}-${version}-windows.zip"
$checksum = "44FB53F26872C6304E1CB3D47B65D0613665666100C48DEEEE4CD87901FB500F"
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

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

# Copy Ventoy.exe and Ventoy2Disk.exe to unzipLocation
Copy-Item -Path "$unzipLocation\ventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\ventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Parse package parameters
$pp = Get-PackageParameters

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
    $noDesktopShortcutFlag = $_[3]
    $noStartMenuShortcutFlag = $_[4]

    $targetPath = Join-Path $unzipLocation $executableName

    # Check and Create Desktop shortcuts
    if (!$pp[$noDesktopShortcutFlag]) {
        $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$shortcutName.lnk"
        Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
    }

    # Check and Create Programs shortcuts
    if (!$pp[$noStartMenuShortcutFlag]) {
        $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$shortcutName.lnk"
        Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation -Arguments $additionalArguments
    }
}