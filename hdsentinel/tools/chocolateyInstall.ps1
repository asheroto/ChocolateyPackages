$ErrorActionPreference = 'Stop'; # Stop on all errors
# https://www.hdsentinel.com/download.php

# Import KillAsap function
. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) 'helpers\KillAsap.ps1')

# Package details
$packageName = "hdsentinel"
$packageTitle = "HDSentinel"
$installerType = "EXE"
$packageVersion = "6.10.4"
$url = "https://www.harddisksentinel.com/hdsentinel_setup.zip"
$silentArgs = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
$checksum = "27B23007859B0D535106B508FEB9B79FEBFA2F891CFF443DAA0418CA4CB85B5B"
$checksumType = "sha256"
$validExitCodes = @(0)

# File and directory paths
$filename = [System.IO.Path]::GetFileName($url)
$tmpDir = Join-Path $env:temp $packageName
$pathToZip = Join-Path $tmpDir $filename

# Download package
Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $pathToZip -Url $url -Checksum $checksum -ChecksumType $checksumType

# Extract package
Get-ChocolateyUnzip -FileFullPath $pathToZip -Destination $tmpDir

# Get installer path
$pathToExe = Join-Path $tmpDir (Get-ChildItem $tmpDir -Filter "*.exe").Name

# Install package
Install-ChocolateyInstallPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -ValidExitCodes $validExitCodes -File $pathToExe

# Terminate any spawned windows by the app post-installation
KillAsap $packageTitle