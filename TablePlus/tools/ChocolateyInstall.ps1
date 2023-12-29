$ErrorActionPreference = "Stop"

$version = "5.8.0"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://download.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "17A63DB214FC29A2D13AD59B6B633E492F127AA5C589A398E62F5C42C1264E26"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs