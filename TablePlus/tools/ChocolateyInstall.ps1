$ErrorActionPreference = "Stop"

$version = "26.10.2"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "733531702933DA6251C8685D03E9184E4B9A5046D4B12455FC57BA43F30C2582"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
