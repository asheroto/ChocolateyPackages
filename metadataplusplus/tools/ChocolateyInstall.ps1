$ErrorActionPreference = 'Stop'

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = "3.0.1"
    Url            = "https://www.logipole.com/download/metadata++-3-00-1.exe"
    Checksum       = "59F4DF9452D0E70DF4B949FBAA9929719D2A8C1A3A816AFBBCFC755E3524EC4B"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs