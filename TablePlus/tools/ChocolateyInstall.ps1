$ErrorActionPreference = "Stop"

$version = "5.8.8"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "CCF9590A0DFB59416D3774185CE3B04AE82185DB0D05A678E2F4CE28864943C7"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs