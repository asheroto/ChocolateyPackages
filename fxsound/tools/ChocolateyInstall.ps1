$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'fxsound'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\fxsound_setup.exe" # URL: https://download.fxsound.com/fxsoundlatest
    checksum       = '3541DF625AFFA384FEACF3CD3D64C47D2372EAB9A2055D57DDE08AFE7F85862C'
    checksumType   = 'sha256'
    silentArgs     = '/exenoui /qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'FxSound*'
}

Install-ChocolateyInstallPackage @packageArgs