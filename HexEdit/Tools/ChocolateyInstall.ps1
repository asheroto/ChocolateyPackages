$packageName = 'HexEdit'
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$cpu = if ($is64bit) { 'amd64' } else { 'x86' }
$url = 'http://www.catch22.net/sites/default/files/hexedit-' + $cpu + '-' + '2.0.6.49' + '.zip'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $drop
