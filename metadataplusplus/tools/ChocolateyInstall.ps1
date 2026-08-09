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
    Url            = "https://www.logipole.com/download/metadata++-3-00-1.exe"
    Checksum       = "59F4DF9452D0E70DF4B949FBAA9929719D2A8C1A3A816AFBBCFC755E3524EC4B"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs