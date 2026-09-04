$ErrorActionPreference = "Stop"

$version = "26.10.1"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "0F6793DD5B3E34CA25FA7416A1942DDAB8376D9DF9EECE8913F906362E98F0C0"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
