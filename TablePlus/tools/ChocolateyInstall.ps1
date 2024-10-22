$ErrorActionPreference = "Stop"

$version = "6.1.4"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "975549C6DACE43E5DE9E3D9C6190DB02923117ACF6A3EC7EA323B95A583FFD5F"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
