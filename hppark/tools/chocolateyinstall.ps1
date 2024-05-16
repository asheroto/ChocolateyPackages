$ErrorActionPreference = 'Stop'

# Download:
# https://support.hp.com/us-en/drivers/supd/model/33835514
# https://support.hp.com/us-en/drivers/upd/model/4157320
# Using the link from the download button won't work for scraping the version number due to the HP website.
# Using VisualPing to monitor the version as it supports clicking. Check ran weekly.

# Parameters
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version      = "1.9.1"
$shortcutName = 'HP PARK.lnk'
$subfolder    = "HP PARK-v$ENV:ChocolateyPackageVersion"

# Package arguments
$packageArgs = @{
    packageName   = 'hppark'
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = "https://ftp.hp.com/pub/softlib/software13/printers/UPD/HP-PARK-v${VERSION}.zip"
    checksum      = 'AE6F21CFDD6286FFC786BBE1A81E654F0420BC5DBD83EDC1C0104276A28B4C68'
    checksumType  = 'sha256'
}

# Install the package
Install-ChocolateyZipPackage @packageArgs

# Create a desktop shortcut
$shortcutPath = [System.IO.Path]::Combine($ENV:Public, 'Desktop', $shortcutName)
$targetPath = [System.IO.Path]::Combine($toolsDir, $subfolder)
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $targetPath