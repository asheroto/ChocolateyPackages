$ErrorActionPreference = "Stop"

$version = "26.7.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "A14F6D86BC1DA8793CE03866549E032D4187EC7C876B7BF2B14AB77A97FA0AA4"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
