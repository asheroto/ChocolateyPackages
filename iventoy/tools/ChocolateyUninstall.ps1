$ErrorActionPreference = "Stop"

$packageName = "iventoy"

# Set new install location to $env:ChocolateyInstall\lib\iventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

# Array of shortcut locations
$shortcutFolders = @([Environment]::GetFolderPath("Programs"), [Environment]::GetFolderPath("Desktop"))

# Shortcut base names
$shortcutNames = @('iVentoy', 'iVentoy ISOs')

# Remove shortcuts from Programs and Desktop
foreach ($folder in $shortcutFolders) {
    foreach ($name in $shortcutNames) {
        $targetPath = Join-Path $folder "$name.lnk"
        if (Test-Path $targetPath) {
            Remove-Item -Path $targetPath -ErrorAction SilentlyContinue
        }
    }
}

# On uninstall, remove all files/folders except the iso folder and its contents in $unzipLocation
if (Test-Path $unzipLocation) {
    # Retrieve all items from the uninstall location, except the 'iso' folder
    $items = Get-ChildItem -Path $unzipLocation -Recurse -Force | Where-Object { $_.FullName -notlike "*\iso\*" -and $_.FullName -ne "$unzipLocation\iso" }

    # Remove each item that is not the 'iso' folder or its contents
    foreach ($item in $items) {
        Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}