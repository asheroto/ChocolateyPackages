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
    Url            = "https://www.logipole.com/download/metadata++-3-00-3.exe"
    Checksum       = "F2A61613991A93B298E0873712C3B272A6FC034862146FB5DA6A966124893B96"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs