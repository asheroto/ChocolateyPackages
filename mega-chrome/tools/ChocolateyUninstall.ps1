$ErrorActionPreference = 'Stop'
$Bits = Get-ProcessorBits
$ExtensionID = 'bigefpfhnfcobdlfbedofhhaibnlghod'
$BasePath = if ($Bits -eq 64) { 'HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions' } else { 'HKLM:\SOFTWARE\Google\Chrome\Extensions' }
$ExtensionPath = Join-Path -Path $BasePath -ChildPath $ExtensionID

Remove-Item -Path $ExtensionPath -Force -ErrorAction SilentlyContinue | Out-Null