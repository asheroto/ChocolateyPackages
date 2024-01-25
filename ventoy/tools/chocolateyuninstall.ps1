$ErrorActionPreference = "Stop";

$packageName = "ventoy"
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

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