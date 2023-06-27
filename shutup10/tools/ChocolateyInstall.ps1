# Create shortcuts
$chocoBinPath = Join-Path -Path $env:ChocolateyInstall -ChildPath 'bin'
@(
	, @('O&O ShutUp10++', 'OOSU10.exe')
) | ForEach-Object {
	$shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
	$exePath = Join-Path $chocoBinPath $_[1]
	Install-ChocolateyShortcut `
		-ShortcutFilePath $shortcutPath `
		-Target $exePath
}