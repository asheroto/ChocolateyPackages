$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'fxsound'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\fxsound_setup.exe" # URL: https://download.fxsound.com/fxsoundlatest
    checksum       = '532882059D3EEBB00E8B1A5DA89A622B3A65CF2C6D8DA3529A6FDC9DF2FBE396'
    checksumType   = 'sha256'
    silentArgs     = '/exenoui /qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'FxSound*'
}

Install-ChocolateyInstallPackage @packageArgs