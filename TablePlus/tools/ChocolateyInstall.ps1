$ErrorActionPreference = "Stop"

$version = "5.9.7"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "9C952ED40B9A145B5B17682AFF8F128D2EF0046A87B7C40D7D4FAC2F29CCC41B"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs