$ErrorActionPreference = "Stop"

$version = "5.7.1"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://download.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "BF96F7A6445E2F453484B856B90650920687E7226765F8D06DA22A9B0215E1CA"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs