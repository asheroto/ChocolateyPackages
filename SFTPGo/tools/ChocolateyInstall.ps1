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

$DefaultDataPath = Join-Path -Path $ENV:ProgramData -ChildPath "SFTPGo"
$DefaultConfigurationFilePath = Join-Path -Path $DefaultDataPath -ChildPath "config.json"

# `t = tab
Write-Output "---------------------------"
Write-Output ""
Write-Output "If you have never used SFTPGo before, the web administration panel is located here:"
Write-Output "`thttp://localhost:8080"
Write-Output ""
Write-Output "Default web administration port:"
Write-Output "`t8080"
Write-Output "Default SFTP port:"
Write-Output "`t2022"
Write-Output ""
Write-Output "Default data location:"
Write-Output "`t$DefaultDataPath"
Write-Output "Default configuration file location:"
Write-Output "`t$DefaultConfigurationFilePath"
Write-Output ""
Write-Output "General information (README) location:"
Write-Output "`thttps://github.com/drakkan/sftpgo"
Write-Output "Detailed information (docs folder) location:"
Write-Output "`thttps://github.com/drakkan/sftpgo/tree/main/docs"
Write-Output ""
Write-Output "---------------------------"