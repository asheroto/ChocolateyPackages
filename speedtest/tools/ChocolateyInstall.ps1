$ErrorActionPreference = 'Stop'

$toolsDir = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$PackageParameters = Get-PackageParameters

# Parameters
$installDir = if ($PackageParameters.InstallDir) { $PackageParameters.InstallDir } else { $toolsDir }

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $installDir
    version       = "1.2.0"
    url           = "https://install.speedtest.net/app/cli/ookla-speedtest-${VERSION}-win64.zip"
    checksum      = "13E3D888B845D301A556419E31F14AB9BFF57E3F06089EF2FD3BDC9BA6841EFA"
    checksumType  = "sha256"
}
Install-ChocolateyZipPackage @packageArgs

$targetPath = [System.IO.Path]::Combine($installDir, 'speedtest.exe')

# Add StartMenu shortcut
if ($PackageParameters.StartMenuShortcut) {
    Write-Output "Adding Start Menu shortcut..."
    $programsPath = [System.IO.Path]::Combine($env:ProgramData, 'Microsoft', 'Windows', 'Start Menu', 'Programs')
    $programsFilePath = [System.IO.Path]::Combine($programsPath, 'Speedtest CLI.lnk')
    Install-ChocolateyShortcut -ShortcutFilePath $programsFilePath -TargetPath $targetPath
}