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

	checksum       = '058DEE2770FBDE09D0C6CAE9B89B98F8ABC6BBA56A5F06EA43326E07D544944B'
	checksumType   = 'sha256'
	checksum64     = $checksum
	checksumType64 = 'sha256'

	validExitCodes = @(0)
	silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs