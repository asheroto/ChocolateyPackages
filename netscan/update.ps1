[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# netscan is a metapackage for netscan.install, so it has no installer to check.
# Mirror the netscan.install version (run after netscan.install/update.ps1).

# Set vars to the script and the parent path
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

$PackageName = 'netscan'
$NuspecPath = Join-Path $ScriptPath "$PackageName.nuspec"
$InstallNuspecPath = Join-Path $ParentPath 'netscan.install\netscan.install.nuspec'

Push-Location $ScriptPath
try {
    $InstallVersion = ([regex]::Match((Get-Content $InstallNuspecPath -Raw), '<version>(.*?)</version>')).Groups[1].Value
    $NuspecVersion = ([regex]::Match((Get-Content $NuspecPath -Raw), '<version>(.*?)</version>')).Groups[1].Value

    Write-Output "netscan.install version: $InstallVersion"
    Write-Output "Nuspec version: $NuspecVersion"

    if ($InstallVersion -notmatch '^\d+(\.\d+){1,3}$') {
        throw "Invalid netscan.install version: $InstallVersion"
    }

    if ($InstallVersion -eq $NuspecVersion) {
        Write-Output "No update needed."
        return
    }

    # Update the package version and the dependency version
    $content = Get-Content $NuspecPath -Raw
    $content = $content -replace '(?<=<version>).*?(?=</version>)', $InstallVersion
    $content = $content -replace '<dependency id="netscan.install"[^/]*/>', "<dependency id=`"netscan.install`" version=`"$InstallVersion`" />"
    Set-Content -Path $NuspecPath -Value $content -NoNewline
    Write-Output "Updated to version $InstallVersion"

    # Delete old nupkg files, then pack and push
    Get-ChildItem -Path $ScriptPath -Filter "$PackageName.*.nupkg" -File | Remove-Item -Force

    choco pack
    if ($LASTEXITCODE -ne 0) { throw "choco pack failed with exit code $LASTEXITCODE" }

    choco push "$PackageName.$InstallVersion.nupkg"
    if ($LASTEXITCODE -ne 0) { throw "choco push failed with exit code $LASTEXITCODE" }
} catch {
    Write-Warning "An error occurred: $_"
} finally {
    Write-Output "Done."
    Pop-Location
}
