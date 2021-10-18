$ErrorActionPreference  = 'Stop'
$packageName    = 'sftpgo'
$softwareName   = 'SFTPGo'
$url            = 'https://github.com/drakkan/sftpgo/releases/download/v2.1.2/sftpgo_v2.1.2_windows_x86_64.exe'
$checksum       = '86E744E9056B7376A0EB66D027E983843126C3617773C410B1F9DC38E172FDD7'
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0)

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

Write-Output "---------------------------"
Write-Output ""
Write-Output "If you have never used SFTPGo before, the default installation is at:"
Write-Output "  http://localhost:8080"
Write-Output ""
Write-Output "The default SFTP port is 2022"
Write-Output ""
Write-Output "The default data:"
Write-Output "  $ENV:ProgramData\SFTPGo"
Write-Output ""
Write-Output "See the README at https://github.com/drakkan/sftpgo for more information"
Write-Output ""
Write-Output "---------------------------"
