$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$PackageParameters = Get-PackageParameters

### PARAMETERS
If ($PackageParameters.InstallDir) {
    $installDir = $PackageParameters.InstallDir
} else {
    $installDir = "$toolsDir"
}

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $installDir
    version       = "1.2.0"
    url           = "https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-win64.zip"
    checksum      = "13E3D888B845D301A556419E31F14AB9BFF57E3F06089EF2FD3BDC9BA6841EFA"
    checksumType  = "sha256"
}
Install-ChocolateyZipPackage @packageArgs

$targetPath = Join-Path "$installDir" "speedtest.exe"

# Add StartMenu shortcut
If ( $PackageParameters.StartMenuShortcut ) {
    $programsPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\"
    $programsFilePath = Join-Path "$programsPath" "Speedtest CLI.lnk"
    Install-ChocolateyShortcut -shortcutFilePath "$programsFilePath" -targetPath "$targetPath"
}