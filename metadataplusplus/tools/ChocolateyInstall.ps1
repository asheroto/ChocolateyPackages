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
    Url            = "https://www.logipole.com/download/metadata++-3-00-5.exe"
    Checksum       = "FD938645009868BB0832CB6345DD90053EB3CFF7793BACE7BC43A1875D84673E"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs