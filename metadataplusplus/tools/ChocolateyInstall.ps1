$ErrorActionPreference = 'Stop'

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = "2.05.2"
    Url            = "https://www.logipole.com/download/metadata++/metadata++-2-05-2.exe"
    Checksum       = "46EB6C013B1137A740F5679AC283F65B64975AE1091446985AC077A03448DDE8"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs