$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'fxsound'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\fxsound_setup.exe" # URL: https://download.fxsound.com/fxsoundlatest
    checksum       = 'B33AE29A2C03A2C155BD8368B624EF1BE7D6ADA470B5DD46A4804BDFB49BE838'
    checksumType   = 'sha256'
    silentArgs     = '/exenoui /qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'FxSound*'
}

Install-ChocolateyInstallPackage @packageArgs