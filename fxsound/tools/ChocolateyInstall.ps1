$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'fxsound'
    fileType       = 'exe'
    file           = "$(Split-Path $MyInvocation.MyCommand.Definition)\fxsound_setup.exe" # URL: https://download.fxsound.com/fxsoundlatest
    checksum       = '7DBC411488E4E653769F98B014F2A24B185B24653CEE04FA5ED59B03438DA7E7'
    checksumType   = 'sha256'
    silentArgs     = '/exenoui /qn /norestart'
    validExitCodes = @(0)
    softwareName   = 'FxSound*'
}

Install-ChocolateyInstallPackage @packageArgs