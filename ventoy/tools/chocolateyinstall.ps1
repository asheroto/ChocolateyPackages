# exe location
# ventoy-$version
# └── Ventoy2Disk.exe

$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'ventoy-1.0.54-windows.zip'
$packageName = $env:ChocolateyPackageName
$shortcutPath = [Environment]::GetFolderPath("Programs") + '\Ventoy.lnk'
$unzipLocation = "$Env:LOCALAPPDATA\$packageName"
$version = $env:ChocolateyPackageVersion

$packageArgs = @{
	packageName   = $packageName
	unzipLocation = $unzipLocation
	file          = "$toolsDir\$fileName32"
}

Install-ChocolateyZipPackage @packageArgs

Copy-Item -Path "$unzipLocation/ventoy-$version/*" -Destination $unzipLocation -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipLocation/ventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

$exePath = (Get-ChildItem $unzipLocation -Filter "Ventoy2Disk.exe" -Recurse).FullName
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -Target "$exePath" -WorkingDirectory $unzipLocation
