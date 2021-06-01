$ErrorActionPreference = 'Stop'
$packageName = 'mega-firefox'
$url = 'https://mega.nz/meganz.xpi'
$extensionID = "{2374ae73-2522-4236-bce9-59224a9a1ed6}"

if (test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs') {
    $installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if (test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs') {
    $installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $extFolder
    fileType      = 'ZIP' 
    url           = $url
    checksum      = '7eb88f76caa99e49747f73a27564dd950ac558526cce720909cbcf8811731677'
    checksumType  = 'sha256' 
}

if (!(Test-Path $extFolder)) {
    New-Item -Force -ItemType directory -Path $extFolder 
    Install-ChocolateyZipPackage @packageArgs
} else {
    Write-Host "$packageName already exists"
}