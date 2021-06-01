$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'mega-edge'
$extensionID = 'jemjknhgpjaacbghpdhgchbgccbpkkgf'
if ($bits -eq 64) {
    if (Test-Path -Path "HKLM:\SOFTWARE\Wow6432node\Microsoft\Edge\Extensions\$extensionID") {
        Write-Host "Extension already installed." -foreground "magenta" –backgroundcolor "blue"
    } else {
        New-Item -Force -Path "HKLM:\SOFTWARE\Wow6432node\Microsoft\Edge\Extensions\$extensionID" | out-null
        New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Microsoft\Edge\Extensions\$extensionID\" -Name "update_url" -Value "https://edge.microsoft.com/extensionwebstorebase/v1/crx" | out-null
        New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Microsoft\Edge\Extensions\$extensionID\" -Name "ChocolateyPackageName" -Value "$packageName" | out-null
    }
} else {
    New-Item -Force -Path "HKLM:\SOFTWARE\Microsoft\Edge\Extensions\$extensionID" | out-null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Edge\Extensions\$extensionID\" -Name "update_url" -Value "https://edge.microsoft.com/extensionwebstorebase/v1/crx" | out-null
}