$ErrorActionPreference = "Stop"

$version = "6.7.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "AC0FC40F15EE6F9B9A4C1A73E000874286B0F1D8BFF426F6FA562D8D4BF26253"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
