$ErrorActionPreference = "Stop"

# Define the version
$Version = "3.9.7"

# Define tools directory
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

# Package args
$packageArgs = @{
    PackageName    = "StartAllBack"
    SoftwareName   = "StartAllBack"
    Url            = "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartAllBack_${Version}_setup.exe"
    Checksum       = "501B28286FAC3FF1DAE81AD3F997FBDBDFDD17D6AE57B9E9EF4BF1DC274E64C5"
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