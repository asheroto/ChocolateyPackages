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
    Url            = "https://www.logipole.com/download/metadata++-3-00-2.exe"
    Checksum       = "88E0824783F9E1435E43BDBD5CD35BD7F882A96E91E8C8C80EB2EAD411B44606"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs