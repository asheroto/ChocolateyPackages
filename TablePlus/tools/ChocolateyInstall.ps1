$ErrorActionPreference = "Stop"

$version = "7.0.2"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "4418B7FA70B02C98FA77BEABDC282D0FF37E977A6C005778635DBB60B38DC1F8"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
