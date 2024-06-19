$ErrorActionPreference = 'Stop'

# Package args
$packageArgs = @{
    PackageName    = "metadataplusplus"
    SoftwareName   = "Metadata++*"
    Version        = "2.5.2"
    Url            = "https://www.logipole.com/download/metadata++/metadata++-2-05-2.exe"
    Checksum       = "F05AA56DFB78497B959E1191BA9E50FA0FB5F61DDED60C0C4ABEDB4E2DD517BB"
    ChecksumType   = "sha256"
    SilentArgs     = "/verysilent"
    ValidExitCodes = @(0)
}

# Install
Install-ChocolateyPackage @packageArgs