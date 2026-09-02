$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'fxsound'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\fxsound_setup.exe" # URL: https://download.fxsound.com/fxsoundlatest
    checksum       = '975CC9FA6FEB3C0963E771E4C4CD54917C95EF361DB620A4D487E84847A5FF5E'
    checksumType   = 'sha256'
    silentArgs     = '/exenoui /qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'FxSound*'
}

Install-ChocolateyInstallPackage @packageArgs