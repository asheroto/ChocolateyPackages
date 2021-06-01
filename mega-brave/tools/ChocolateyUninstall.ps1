$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'mega-chrome'
$extensionID = 'bigefpfhnfcobdlfbedofhhaibnlghod'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\BraveSoftware\Brave\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
   }else{
    Remove-Item "HKLM:\SOFTWARE\BraveSoftware\Brave\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
