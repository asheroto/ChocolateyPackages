﻿$ErrorActionPreference = 'Stop'
$packageName = 'mega-firefox'
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

Remove-Item "$extFolder" -Force -Recurse -ErrorAction SilentlyContinue