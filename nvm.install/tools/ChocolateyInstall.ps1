$ErrorActionPreference = 'Stop'

# Define the version
$Version = "2.0.0"

# Define tools directory
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

# Package args
# v2 is an Inno Setup installer that installs per-user (PrivilegesRequired=lowest) into
# %LOCALAPPDATA%\Author Software\nvm and adds itself to the current user's PATH.
# ponytail: amd64 installer only. It runs on arm64 hosts via emulation; add a native arm64 branch if someone asks.
$packageArgs = @{
    PackageName    = $env:ChocolateyPackageName
    FileType       = 'exe'
    SoftwareName   = 'NVM for Windows'
    Url            = "https://github.com/nvm-windows/nvm/releases/download/v${Version}/nvm-${Version}-amd64-setup.exe"
    Checksum       = 'AFAEE67D3D7BC8CCAD0B1B06F63B0F2D6B008BC7E55D5205043F095B4906AC11'
    ChecksumType   = 'sha256'
    SilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
    ValidExitCodes = @(0)
}

# Always warn about the v1 migration the installer performs, since most installs of this version are 1.x
# upgrades. It copies every Node.js version with robocopy and can look stuck for minutes at a time
# (11 versions / 1.3 GB took about 14 minutes on a fast machine, see https://github.com/nvm-windows/nvm/issues/1387).
Write-Warning "=================================================================="
Write-Warning "UPGRADING FROM NVM FOR WINDOWS 1.x? READ THIS."
Write-Warning "If a 1.x install is found, the installer MIGRATES your settings and"
Write-Warning "every installed Node.js version to $env:LOCALAPPDATA\Author Software\nvm,"
Write-Warning "then removes the 1.x install and its system environment variables."
Write-Warning "This package answers the migration prompt automatically."
Write-Warning ""
Write-Warning "THIS IS SLOW: expect 10 to 30 minutes, longer with many Node.js versions."
$v1Home = $env:NVM_HOME
if ($v1Home -and (Test-Path (Join-Path $v1Home 'settings.txt'))) {
    $v1Count = @(Get-ChildItem $v1Home -Directory -Filter 'v*' -ErrorAction SilentlyContinue).Count
    Write-Warning "Found 1.x at $v1Home with $v1Count Node.js version(s): expect about $(5 + (2 * $v1Count)) minutes."
}
Write-Warning "It will look stuck. It is not. Each version is copied by a"
Write-Warning "robocopy.exe process you can watch in Task Manager."
Write-Warning "DO NOT close this window or kill the installer."
Write-Warning "Aborting leaves a half-migrated install. Let it finish."
Write-Warning "(A fast, migration-free path exists: see the package description"
Write-Warning "about uninstalling 1.x first.)"
Write-Warning "=================================================================="
Write-Warning ""
Write-Warning "Continuing in 30 seconds..."
Write-Warning ""
Start-Sleep -Seconds 30

# Download first so the AutoHotkey helper starts right before the installer runs
$installer = Get-ChocolateyWebFile -PackageName $packageArgs.PackageName `
                                   -FileFullPath (Join-Path $toolsDir "nvm-${Version}-amd64-setup.exe") `
                                   -Url $packageArgs.Url `
                                   -Checksum $packageArgs.Checksum `
                                   -ChecksumType $packageArgs.ChecksumType

# When upgrading from v1, the installer shows a migration prompt that /SUPPRESSMSGBOXES cannot
# suppress (https://github.com/nvm-windows/nvm/issues/1386). AutoHotkey clicks "Yes" for us.
# It exits on its own after 60 seconds if no prompt appears (fresh install).
$ahkExe = Get-ChildItem -Path "$env:ProgramData\chocolatey\lib\autohotkey.portable\tools" -Filter "AutoHotKey.exe" -Recurse | Select-Object -First 1 -ExpandProperty FullName
if (-Not $ahkExe) {
    throw "AutoHotKey executable not found. Ensure autohotkey.portable is correctly installed."
}
$ahkProc = Start-Process -FilePath $ahkExe -ArgumentList """$(Join-Path $toolsDir ChocolateyInstallHelper.ahk)""", "nvm-${Version}-amd64-setup.exe" -PassThru
Write-Debug "AutoHotkey helper started, PID $($ahkProc.Id)"

# Install the package
Install-ChocolateyInstallPackage -PackageName $packageArgs.PackageName `
                                 -FileType $packageArgs.FileType `
                                 -SilentArgs $packageArgs.SilentArgs `
                                 -File $installer `
                                 -ValidExitCodes $packageArgs.ValidExitCodes

# Stop the helper if it is still waiting, and drop the downloaded installer
Stop-Process -Id $ahkProc.Id -ErrorAction SilentlyContinue
Remove-Item $installer -ErrorAction SilentlyContinue