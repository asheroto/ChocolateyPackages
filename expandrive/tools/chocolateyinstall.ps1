$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = 'd96ff1ab26bf77327753665eb81a10cc47f8db4d7253a64343ca8869438afd0a'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = ''
  softwareName   = 'Expandrive*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Start-CheckandStop "ExpanDrive"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq $False) {Start-WaitandStop "ExpanDrive"}
if ($ProcessWasRunning -eq $False) {Start-WaitandStop "ExpanDrive"}
