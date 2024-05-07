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

	checksum       = '095D8D3FC1981FB038FBAE7E9A6E9B4808D1330960C7CC7EDA94F51295198DED'
	checksumType   = 'sha256'

	validExitCodes = @(0)
	silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs