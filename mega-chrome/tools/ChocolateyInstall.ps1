$ErrorActionPreference = 'Stop'
$Bits = Get-ProcessorBits
$PackageName = 'mega-chrome'
$ExtensionID = 'bigefpfhnfcobdlfbedofhhaibnlghod'
$BasePath = if ($Bits -eq 64) { 'HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions' } else { 'HKLM:\SOFTWARE\Google\Chrome\Extensions' }
$ExtensionPath = Join-Path -Path $BasePath -ChildPath $ExtensionID

if (Test-Path -Path $ExtensionPath) {
    Write-Output "Extension already installed."
} else {
    New-Item -Force -Path $ExtensionPath | Out-Null
    New-ItemProperty -Path $ExtensionPath -Name 'update_url' -Value 'https://clients2.google.com/service/update2/crx' | Out-Null
    if ($Bits -eq 64) {
        New-ItemProperty -Path $ExtensionPath -Name 'ChocolateyPackageName' -Value $PackageName | Out-Null
    }
}