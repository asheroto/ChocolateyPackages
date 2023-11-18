$ErrorActionPreference = "Stop"

$version = "5.6.9"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://download.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "80D0C65BC7232FB795AD8AE7028402913E10287EB722026445F490E5E3A70029"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs