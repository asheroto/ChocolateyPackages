$ErrorActionPreference = 'Stop'

# Download:
# https://support.hp.com/us-en/drivers/upd/model/4157320
# Using the link from the download button won't work for scraping the version number due to the HP website.
# Using VisualPing to monitor the version as it supports clicking. Check ran weekly.

# Parameters
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = "1.9.2"
$shortcutName = 'HP PARK.lnk'

# Package arguments
$packageArgs = @{
    packageName   = 'hppark'
    unzipLocation = $toolsDir
    fileType      = 'ZIP'
    url           = "https://ftp.hp.com/pub/softlib/software13/printers/UPD/HP-PARK-v${VERSION}.zip"
    checksum      = '29d5ff4ddcd1f2d200dddc3334f5ae0b6b1f2cecb508ca75cb1c7afce120766b'
    checksumType  = 'sha256'
}

# Install the package
Install-ChocolateyZipPackage @packageArgs

# Create a desktop shortcut
$shortcutPath = [System.IO.Path]::Combine($ENV:Public, 'Desktop', $shortcutName)
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $toolsDir