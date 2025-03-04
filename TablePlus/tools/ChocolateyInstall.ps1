$ErrorActionPreference = "Stop"

$version = "6.4.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "E5DC5DEEF795FC2350E1E0BA5CAC44160ACF3B62EF660B6E0F6DE28DFD9DCF52"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
