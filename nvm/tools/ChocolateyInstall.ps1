$ErrorActionPreference	= 'Stop'
$packageName			= 'nvm'
$toolsPath				= Split-Path $MyInvocation.MyCommand.Definition
$silentArgs				= '/verysilent /norestart /suppressmsgboxes'
$fileLocation			= "$toolsPath\nvm-setup.exe"
$url					= "https://github.com/coreybutler/nvm-windows/releases/download/1.1.9/nvm-setup.zip"
$checksum				= "93c135ba59f13b7138a8216b3ef03d88f88d1e3e8420ccbb681244a9070aa475"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'zip'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
Start-Process $fileLocation -ArgumentList $silentArgs