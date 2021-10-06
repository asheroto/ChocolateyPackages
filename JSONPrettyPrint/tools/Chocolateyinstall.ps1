$bits                   = Get-ProcessorBits
$toolsPath              = Split-Path $MyInvocation.MyCommand.Definition
$binary32               = 'JSONPrettyPrint_win-x86.exe'
$binary64               = 'JSONPrettyPrint_win-x64.exe'
$binaryDefault          = 'JSONPrettyPrint.exe'
$friendlyBinaryName     = 'JSONPrettyPrint'

if($bits -eq 64) {
    Copy-Item -Path "$toolsPath\$binary64" -Destination "$toolsPath\$binaryDefault" -Force
} else {
    Copy-Item -Path "$toolsPath\$binary32" -Destination "$toolsPath\$binaryDefault" -Force
}

Write-Output "---------------------------"
Write-Output "Type ""$friendlyBinaryName"" and press enter for more information"
Write-Output "---------------------------"