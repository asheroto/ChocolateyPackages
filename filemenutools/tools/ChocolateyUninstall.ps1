$ErrorActionPreference = 'Stop';

$shortcutsPath = Join-Path ([Environment]::GetFolderPath("Programs")) 'Ventoy.lnk'
$unzipPath = "$Env:LOCALAPPDATA\$env:ChocolateyPackageName"

Remove-Item -Path $shortcutsPath -ErrorAction SilentlyContinue
if (Test-Path $unzipPath) { 
  Remove-Item -Path $unzipPath -Recurse -Force -ErrorAction SilentlyContinue
}
