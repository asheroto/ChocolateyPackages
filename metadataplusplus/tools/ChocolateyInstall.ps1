$ErrorActionPreference = 'Stop'

$Version = $env:ChocolateyPackageVersion

# Author's download URLs pad the middle version part to two digits (3.0.1 -> 3-00-1)
$parts = $Version -split '\.'
$VersionHyphenated = "{0}-{1:00}-{2}" -f [int]$parts[0], [int]$parts[1], [int]$parts[2]

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = $Version
    Url            = "https://www.logipole.com/download/metadata++-3-00-4.exe"
    Checksum       = "A4C03C4170DAA9320DBE791F721BEBE2BF9EDC0618FD605BE20CCF5A953B3EA5"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs