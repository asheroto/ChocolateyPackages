$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '1.1.0'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $toolsDir
    fileType       = 'msi'
    url            = "https://github.com/lencx/ChatGPT/releases/download/v${version}/ChatGPT_${version}_windows_x86_64.msi"
    softwareName   = 'ChatGPT*'
    checksum       = '8442A2ED4D74230A08A3AAB94B658C6250C37197519D86BE7F334C57F8B76625'
    checksumType   = 'sha256'

    silentArgs     = '/quiet'
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
