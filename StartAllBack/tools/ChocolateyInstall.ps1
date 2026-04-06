$ErrorActionPreference = "Stop"

# Define the version
$Version = "3.9.22"

# Define tools directory
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "7064BD007224BD0FDE7414117F5BE998613540ACF735CE8C4B9C23B9BA0ABB88"
    ChecksumType   = "sha256"
    SilentArgs     = "/silent /elevated"
    ValidExitCodes = @(0)
}

# Install the package
Install-ChocolateyPackage @packageArgs

# Determine the path to AutoHotKey executable from autohotkey.portable
$ahkExe = Get-ChildItem -Path "$env:ProgramData\chocolatey\lib\autohotkey.portable\tools" -Filter "AutoHotKey.exe" -Recurse | Select-Object -ExpandProperty FullName

if (-Not $ahkExe) {
    throw "AutoHotKey executable not found. Ensure autohotkey.portable is correctly installed."
}

$ahkFile = Join-Path $toolsDir "ChocolateyInstallHelper.ahk"

# Verify the existence of the AutoHotKey script
if (-Not (Test-Path $ahkFile)) {
    throw "AutoHotKey script not found: $ahkFile"
}

# Start the AutoHotKey process
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"