$bits           = Get-ProcessorBits
$ErrorActionPreference  = 'Stop'
$packageName    = 'sftpgo'
$softwareName   = 'SFTPgo'
$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition
$url            = 'https://github.com/drakkan/sftpgo/releases/download/v2.0.4/sftpgo_v2.0.4_windows_x86_64.exe'
$checksum       = '4fd3ef2647e561fbd43b57774e9d7725345231f0312c021c95e36e6cc665b0ee'
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0)
$fileLocation   = "$toolsPath\SFTPGo_Setup.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs

if($bits -eq 64) {
    $ProgFiles = ${ENV:ProgramFiles}
} else {
    $ProgFiles = ${ENV:ProgramFiles(x86)}
}

Start-Process -FilePath "$ProgFiles\SFTPGo\sftpgo.exe" -ArgumentList {"serve"} -WorkingDirectory "$ENV:ProgramData\SFTPGo"

Write-Output "---------------------------"
Write-Output ""
Write-Output "If you have never used SFTPGo before, the default installation is at:"
Write-Output "  https://localhost:8080"
Write-Output ""
Write-Output "By default data is stored in:"
Write-Output "  $ENV:ProgramData\SFTPGo"
Write-Output ""
Write-Output "Please read the README at https://github.com/drakkan/sftpgo for more information"
Write-Output ""
Write-Output "---------------------------"