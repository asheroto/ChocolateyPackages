$ErrorActionPreference = 'Stop'

# Import KillAsap function
. ([System.IO.Path]::Combine((Split-Path -Parent $MyInvocation.MyCommand.Definition), 'helpers', 'KillAsap.ps1'))

# Package details
$pkgName = "hdsentinel"
$pkgTitle = "HDSentinel"
$instType = "EXE"
$url = "https://www.harddisksentinel.com/hdsentinel_setup.zip"
$silentArgs = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
$checksum = "06748FE03442C6BD4B18D889446BA9E09EC60BD3FA19B83891EF5AB756A8317D"
$checksumType = "sha256"
$validExitCodes = @(0)

# File and directory paths
$filename = [System.IO.Path]::GetFileName($url)
$tmpDir = [System.IO.Path]::Combine($env:temp, $pkgName)
$pathToZip = [System.IO.Path]::Combine($tmpDir, $filename)

# Download package
Get-ChocolateyWebFile -PackageName $pkgName -FileFullPath $pathToZip -Url $url -Checksum $checksum -ChecksumType $checksumType

# Extract package
Get-ChocolateyUnzip -FileFullPath $pathToZip -Destination $tmpDir

# Get installer path
$pathToExe = [System.IO.Path]::Combine($tmpDir, (Get-ChildItem $tmpDir -Filter "*.exe").Name)

# Install package
Install-ChocolateyInstallPackage -PackageName $pkgName -FileType $instType -SilentArgs $silentArgs -ValidExitCodes $validExitCodes -File $pathToExe

# Terminate any spawned windows by the app post-installation
KillAsap $pkgTitle