$ErrorActionPreference = "Stop"

$version = "6.2.2"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "04A28B89D7E23310DAF6FDAA84595171C6A76C2004440D78E7AE99C6E9D5D585"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
