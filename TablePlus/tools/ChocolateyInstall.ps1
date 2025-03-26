$ErrorActionPreference = "Stop"

$version = "6.4.1"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "3FA722BA41C6BDD0FBBC6CA07D27B26628EDF3A1E1491E5482063692533878D5"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
