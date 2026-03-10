$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "netscan.install"
    fileType       = "exe"
    url            = "https://www.softperfect.com/download/freeware/netscan_setup.exe"
    checksum       = "3826182D48EB5EEDC29AC5E84C5E1E59AE1C12BD98EB04F3B22534DA7455BBE1"
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