$ErrorActionPreference = "Stop"

$version = "6.2.1"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "1EA0C55DD92A95821F062D4DD1F96A08A662414EB8165486FCB0BC4D9E802A04"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
