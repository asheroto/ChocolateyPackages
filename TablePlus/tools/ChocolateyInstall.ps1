$ErrorActionPreference = "Stop"

$version = "6.8.1"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "0A438BCDF11D466F9314D4567DA6AE8DBF6BCA205E0658A89D8C6E7BCBF57121"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
