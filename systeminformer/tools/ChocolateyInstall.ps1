$ErrorActionPreference = 'Stop'
$version = "4.0.26241.138"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    url            = "https://github.com/winsiderss/systeminformer/releases/download/v${version}/systeminformer-${version}-release-setup.exe"
    checksum       = 'CEB46BC42CD9993A3A8E9E7002D1F1715E3D2A077D5226D72612E2B8578E51EB'
    checksumType   = 'sha256'
    silentArgs     = '-silent -nostart'
    validExitCodes = @(0)
    softwareName   = 'System Informer'
}

Install-ChocolateyPackage @packageArgs
