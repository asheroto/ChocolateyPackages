$ErrorActionPreference = "Stop"

$version = "6.9.4"

$packageArgs = @{
    packageName    = "TablePlus"
    fileType       = "exe"
    url            = "https://files.tableplus.com/windows/${version}/TablePlusSetup.exe"
    checksum       = "ABD120306C4E0E7A621BA0AEA572F8CCD22DAE08690AB8A2C92D34C26E5C918E"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "TablePlus"
}


Install-ChocolateyPackage @packageArgs
