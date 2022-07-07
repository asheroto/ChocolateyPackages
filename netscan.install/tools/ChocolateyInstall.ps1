$ErrorActionPreference = 'Stop';

$packageName = 'netscan.install'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.softperfect.com/download/freeware/netscan_setup.exe'

$packageArgs = @{
	packageName    = $packageName
	unzipLocation  = $toolsDir
	fileType       = 'EXE'
	url            = $url
	url64bit       = $url

	softwareName   = 'SoftPerfect Network Scanner*'

	checksum       = '55D79FA1517CE9416AB00F7C55A6939D969F8E84DD456E648E9E6E56520DB152'
	checksumType   = 'sha256'
	checksum64     = $checksum
	checksumType64 = 'sha256'

	validExitCodes = @(0)
	silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs