$ErrorActionPreference = "Stop"

$packageName = "iventoy"

# Set new install location to $env:ChocolateyInstall\lib\iventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)
$isoPath = Join-Path $unzipLocation "iso"

# Array of shortcut locations
$shortcutFolders = @([Environment]::GetFolderPath("Programs"), [Environment]::GetFolderPath("Desktop"))
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

# Check if the iso folder is empty before taking action
if (Test-Path $unzipLocation) {
    $isoContents = Get-ChildItem -Path $isoPath -Recurse
    if ($isoContents) {
        # iso folder contains data, remove everything except the iso folder
        Get-ChildItem -Path $unzipLocation -Recurse -Exclude "iso" |
        Where-Object { -not $_.FullName.StartsWith($isoPath, [System.StringComparison]::OrdinalIgnoreCase) } |
        ForEach-Object {
            try {
                # Write-Output "Removing item: $($_.FullName)"
                Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
            } catch {
                Write-Output "Error removing item: $($_.Exception.Message)"
            }
        }
    } else {
        # iso folder is empty, remove the entire iventoy directory
        try {
            Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction Stop
        } catch {
            Write-Output "Error removing directory ${unzipLocation}: $($_.Exception.Message)"
        }
    }
}