$ErrorActionPreference = "Stop"

$version = "5.6.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://download.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "33C033E3BE3599FCA20B40EE251B4328B474A4925513E32E3315C2F8CF3711AE"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs