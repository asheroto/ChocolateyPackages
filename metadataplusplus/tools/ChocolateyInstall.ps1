$ErrorActionPreference = 'Stop'

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = "2.05.1"
    Url            = "https://www.logipole.com/download/metadata++/metadata++-2-05-1.exe"
    Checksum       = "4AFEA99FC1E94AC71AD7B0178109A66C5B3E5C53A2B36E0009B87A6ECA483918"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs