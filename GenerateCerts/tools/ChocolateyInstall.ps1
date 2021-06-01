$bits                   = Get-ProcessorBits
$toolsPath              = Split-Path $MyInvocation.MyCommand.Definition
$binary32               = 'GenerateCerts_win-x86exe'
$binary64               = 'GenerateCerts_win-x64.exe'
$binaryDefault          = 'GenerateCerts.exe'
$friendlyBinaryName     = 'GenerateCerts'

if($bits -eq 64) {
    Copy-Item -Path "$toolsPath\$binary64" -Destination "$toolsPath\$binaryDefault" -Force
} else {
    Copy-Item -Path "$toolsPath\$binary32" -Destination "$toolsPath\$binaryDefault" -Force
}

Write-Output "---------------------------"
Write-Output "Type ""$friendlyBinaryName"" and press enter to use"
Write-Output "---------------------------"
