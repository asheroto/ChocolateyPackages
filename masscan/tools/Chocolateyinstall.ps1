$bits           = Get-ProcessorBits
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$binary32       = 'masscan32.exe'
$binary64       = 'masscan64.exe'
$binaryDefault  = 'masscan.exe' 

if($bits -eq 64) {
    Copy-Item -Path "$toolsPath\$binary64" -Destination "$toolsPath\$binaryDefault" -Force
} else {
    Copy-Item -Path "$toolsPath\$binary32" -Destination "$toolsPath\$binaryDefault" -Force
}