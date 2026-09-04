$ErrorActionPreference = 'Stop'

# Define the version
# ponytail: testing the 2.0.1-hotfix.1 prerelease, which is the first build to fix the silent
# migration prompt (nvm-windows/nvm#1386) and drop robocopy /V (#1387). Swap to 2.0.1 when it ships.
$Version = "2.0.1-hotfix.1"

# Package args
# v2 is an Inno Setup installer that installs per-user (PrivilegesRequired=lowest) into
# %LOCALAPPDATA%\Author Software\nvm and adds itself to the current user's PATH.
# ponytail: amd64 installer only. It runs on arm64 hosts via emulation; add a native arm64 branch if someone asks.
$packageArgs = @{
    PackageName    = $env:ChocolateyPackageName
    FileType       = 'exe'
    SoftwareName   = 'NVM for Windows'
    Url            = "https://github.com/nvm-windows/nvm/releases/download/v${Version}/nvm-${Version}-amd64-setup.exe"
    Checksum       = '1F0BAA3A094E6796E639617BAC1DFA35C7B998477801D47E376201077D857FF7'
    ChecksumType   = 'sha256'
    SilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
    ValidExitCodes = @(0)
}

# Warn about the v1 migration. When a 1.x install is found the installer copies every installed
# Node.js version into the new per-user folder before removing 1.x, which can take a while.
Write-Warning "=================================================================="
Write-Warning "UPGRADING FROM NVM FOR WINDOWS 1.x? READ THIS."
Write-Warning "If a 1.x install is found, the installer MIGRATES your settings and"
Write-Warning "every installed Node.js version to $env:LOCALAPPDATA\Author Software\nvm,"
Write-Warning "then removes the 1.x install and its system environment variables."
Write-Warning ""
Write-Warning "This copies every Node.js version and can take several minutes,"
Write-Warning "longer if you have many. It may look stuck. It is not."
$v1Home = $env:NVM_HOME
if ($v1Home -and (Test-Path (Join-Path $v1Home 'settings.txt'))) {
    $v1Count = @(Get-ChildItem $v1Home -Directory -Filter 'v*' -ErrorAction SilentlyContinue).Count
    Write-Warning "Found 1.x at $v1Home with $v1Count Node.js version(s)."
}
Write-Warning "DO NOT close this window or kill the installer; aborting leaves a"
Write-Warning "half-migrated install. Let it finish."
Write-Warning "(A fast, migration-free path exists: see the package description"
Write-Warning "about uninstalling 1.x first.)"
Write-Warning "=================================================================="
Write-Warning ""
Write-Warning "Continuing in 30 seconds..."
Write-Warning ""
Start-Sleep -Seconds 30

# Install the package
Install-ChocolateyPackage @packageArgs
