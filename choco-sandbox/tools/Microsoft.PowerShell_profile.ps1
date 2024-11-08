# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
function cinst {choco install $args}
function cuninst {choco uninstall $args}
function cup {choco upgrade $args}
function clist {choco list $args}
function cweb {param ([string]$package ) 
if (($package -eq '') -or ($package -eq '.')) {$package=(Split-Path -Leaf $(Get-Location).Path)}
start https://community.chocolatey.org/packages/$package
}
