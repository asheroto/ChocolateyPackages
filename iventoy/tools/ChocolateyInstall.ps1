$ErrorActionPreference	= "Stop";

# Release URL: https://github.com/ventoy/PXE/releases
$packageName = "iventoy"
$version = "1.0.28" # Chocolatey package version may differ from the filename version
$url = "https://github.com/ventoy/PXE/releases/download/v${version}/iventoy-${version}-win64-free.zip"
$checksum = "62981E71D264FCDF0954B8E451A1F62D07A6E84C2EB002BBD5415053FAB7417A"

# Set new install location to ChocolateyInstall\lib\iventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $unzipLocation
    fileType      = 'ZIP'
    url           = $url
    checksum      = $checksum
    checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Move iso folder and remove iVentoy directory in old location if it exists (local app data) - implemented April 2024
$oldUnzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName
$oldIsoPath = Join-Path $oldUnzipLocation "iso"

# If the old location exists, move the iso folder to the new location
if (Test-Path $oldUnzipLocation) {
    $isoContents = Get-ChildItem -Path $oldIsoPath -Recurse
    if ($isoContents) {
        # move iso folder to new location
        Move-Item -Path $oldIsoPath -Destination $unzipLocation -Force -ErrorAction SilentlyContinue

        # iso folder contains data, remove everything except the iso folder
        Get-ChildItem -Path $unzipLocation -Recurse -Exclude "iso" |
        Where-Object { -not $_.FullName.StartsWith($isoFolder, [System.StringComparison]::OrdinalIgnoreCase) } |
        ForEach-Object {
            try {
                Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
            } catch {
                Write-Output "Error removing item: $($_.Exception.Message)"
            }
        }

        # Confirm the old iso folder was moved, if so, remove the iventoy directory
        if (-Not (Test-Path $oldIsoPath)) {
            try {
                Remove-Item -Path $oldUnzipLocation -Recurse -Force -ErrorAction Stop
            } catch {
                Write-Output "Error removing directory ${oldUnzipLocation}: $($_.Exception.Message)"
            }
        } else {
            Write-Output "Error moving iso folder to new location, old location still exists: ${oldIsoPath}"
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

# Copy all files/folders from the iventoy-$version folder to the unzipLocation
Copy-Item -Path "$unzipLocation\iventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\iventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
    , @('iVentoy', 'iVentoy_64.exe')
    , @('iVentoy ISOs', 'iso')
) | ForEach-Object {
    $targetPath = Join-Path $unzipLocation $_[1]

    # Create Programs shortcuts
    $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"

    # If the $targetPath exists, create a shortcut
    if (Test-Path $targetPath) {
        Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
    }

    # Create Desktop shortcuts
    $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"

    # If the $targetPath exists, create a shortcut
    if (Test-Path $targetPath) {
        Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $targetPath -WorkingDirectory $unzipLocation
    }
}