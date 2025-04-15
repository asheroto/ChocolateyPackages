$ErrorActionPreference = "Stop"

$version = "6.4.8"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "1E6D0A58C1428F57207DEFA840AC6D56AC7A8D2357BE07C337C7BA5CC65D50AA"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
