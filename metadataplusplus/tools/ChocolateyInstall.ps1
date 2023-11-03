$ErrorActionPreference = 'Stop'

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = "2.05.0"
    Url            = "https://www.logipole.com/download/metadata++/metadata++-2-05-0.exe"
    Checksum       = "510C95C5BA03E419F5AE47C0063CB74D7DBEEDBF979BB501AAC0F25BF7C10762"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs