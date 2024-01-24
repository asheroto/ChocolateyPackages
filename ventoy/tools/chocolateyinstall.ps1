$ErrorActionPreference = "Stop";

# ventoy-$version
# └── Ventoy.exe
# └── Ventoy2Disk.exe
# └── other data

# Release URL: https://github.com/ventoy/Ventoy/releases
$packageName   = "ventoy"
$version       = "1.0.97" # Chocolatey package version may differ from the filename version
$url           = "https://github.com/ventoy/Ventoy/releases/download/v${version}/${packageName}-${version}-windows.zip"
$checksum      = "44FB53F26872C6304E1CB3D47B65D0613665666100C48DEEEE4CD87901FB500F"
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

# Create shortcuts
@(
    , @('Ventoy', 'Ventoy2Disk.exe')
    , @('Ventoy Plugson', 'VentoyPlugson.exe')
) | ForEach-Object {
    $targetPath = Join-Path $unzipLocation $_[1]

    # Create Programs shortcuts
    $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation

    # Create Desktop shortcuts
    $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
}