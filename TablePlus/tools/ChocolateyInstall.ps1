$ErrorActionPreference = "Stop"

$version = "5.8.2"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://download.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "36D0ECBB7631FE9F50BD87EC1FA75CC096004D47001C739A4184FFA232BEDB84"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs