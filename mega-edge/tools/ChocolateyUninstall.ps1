$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'mega-edge'
$extensionID = 'jemjknhgpjaacbghpdhgchbgccbpkkgf'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Microsoft\Edge\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
   }else{
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Edge\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
