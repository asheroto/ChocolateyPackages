$ErrorActionPreference	= "Stop";

# Release URL: https://github.com/ventoy/PXE/releases
$packageName   = "iventoy"
$version       = "1.0.20" # Chocolatey package version may differ from the filename version
$url           = "https://github.com/ventoy/PXE/releases/download/v${version}/iventoy-${version}-win32-free.zip"
$checksum      = "0C7A81FF54B7449B90A4774E3BE1EA692E8B7A9DCA941A2DC324A0FA844C3788"
$url64         = "https://github.com/ventoy/PXE/releases/download/v${version}/iventoy-${version}-win64-free.zip";
$checksum64    = "BE41A256B44C872CC15229E273B32F62E41E22371E14D6AEFE7F5A72C0D3E51A"

# Set new install location to ChocolateyInstall\lib\iventoy - implemented April 2024
$unzipLocation = [System.IO.Path]::Combine($env:ChocolateyInstall, "lib", $packageName)

# Remove iVentoy directory in old location if it exists (local app data) - implemented April 2024
$oldUnzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName
if (Test-Path $oldUnzipLocation) {
    # Remove all files/folders except the iso folder
    Get-ChildItem -Path $oldUnzipLocation | Where-Object { $_.Name -ne "iso" } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

    # Move the iso folder to the new location
    $isoPath = Join-Path $oldUnzipLocation "iso"
    if (Test-Path $isoPath) {
        # Ensure the new install location exists
        if (-not (Test-Path $unzipLocation)) {
            New-Item -Path $unzipLocation -ItemType Directory -Force
        }

        # Move the iso folder
        $newIsoPath = Join-Path $unzipLocation "iso"
        Move-Item -Path $isoPath -Destination $newIsoPath -Force

        # Remove the old unzip location if it is empty
        if (-not (Get-ChildItem -Path $oldUnzipLocation)) {
            Remove-Item -Path $oldUnzipLocation -Force
        }
    }
}

$packageArgs = @{
    packageName    = $packageName
    unzipLocation  = $unzipLocation
    fileType       = 'ZIP'
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    url64          = $url64
    checksum64     = $checksum64
    checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# Copy all files/folders from the iventoy-$version folder to the unzipLocation
Copy-Item -Path "$unzipLocation\iventoy-$version\*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation\iventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

# Create shortcuts
@(
    , @('iVentoy', 'iVentoy_32.exe')
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