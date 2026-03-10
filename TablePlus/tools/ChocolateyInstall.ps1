$ErrorActionPreference = "Stop"

$version = "6.9.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "15F2588EF8CC6B89B7775C0143B078079776653FCD2118C4FCF203E22F6C5AF9"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
