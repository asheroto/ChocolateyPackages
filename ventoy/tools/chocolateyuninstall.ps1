$ErrorActionPreference = "Stop";

$packageName = "ventoy"

# Removed April 2024 to account for all users (stopped using LocalApplicationData)
# $unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

# Added April 2024 to account for all users (switched to ChocolateyInstall\lib\ventoy)
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

# Uninstalling shortcuts
# Each entry in the array has the format: [Shortcut Name, Target Executable]
@(
    , @('Ventoy')
    , @('Ventoy Plugson')
    , @('Ventoy Vlnk')
) | ForEach-Object {
    # Assigning values to variables for clarity
    $shortcutName = $_[0]

    # Remove Programs shortcuts
    $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$shortcutName.lnk"
    Remove-Item -Path $programsShortcutPath -ErrorAction SilentlyContinue

    # Remove Desktop shortcuts
    $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$shortcutName.lnk"
    Remove-Item -Path $desktopShortcutPath -ErrorAction SilentlyContinue
}

# Remove Ventoy directory if it exists
if (Test-Path $unzipLocation) {
    Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue
}