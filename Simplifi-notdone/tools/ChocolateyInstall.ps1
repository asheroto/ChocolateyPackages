$ErrorActionPreference  = 'Stop'
$packageName    = 'MessagesForWeb'
$softwareName   = 'Messages for Web'
$url            = 'https://github.com/asheroto/MessagesForWeb/releases/download/0.0.6.1/MessagesForWeb.exe'
$checksum       = '5CE785E48717F3BBCF9658C1D192857223DAACE0019FD88341F5B807A1067733'
$silentArgs     = '/quiet'
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