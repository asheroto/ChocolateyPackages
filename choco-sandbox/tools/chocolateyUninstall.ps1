$ErrorActionPreference = 'Stop'
$packageName  = 'choco-windows-sandbox'
$shortcutName = 'Chocolatey Sandbox.lnk'
$scriptDir    = "$(Get-ToolsLocation)\BCURRAN3\choco-sandbox"

Remove-Item "$scriptDir" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:Public\Desktop\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction SilentlyContinue
