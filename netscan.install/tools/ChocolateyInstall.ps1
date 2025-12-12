$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "netscan.install"
    fileType       = "exe"
    url            = "https://www.softperfect.com/download/freeware/netscan_setup.exe"
    checksum       = "672A4A582D1B1537F03CEFE92685CCDD0D65EDA2605F33EBE6EC7BEA7A27829C"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
    validExitCodes = @(0)
    softwareName   = "SoftPerfect Network Scanner*"
}

# End process
Get-Process netscan -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Notify user about frequently changing checksum
Write-Output ""
Write-Warning "The checksum for this package often changes while the version number remains the same."
Write-Output "While we try to keep this package up to date, you may still encounter errors if the checksum changes and the package is pending approval."
Write-Output "If you experience checksum errors when installing, consider downloading the software from SoftPerfect's website, or as a less secure alternative, run with --ignore-checksums."
Write-Output ""

# Install
Install-ChocolateyPackage @packageArgs