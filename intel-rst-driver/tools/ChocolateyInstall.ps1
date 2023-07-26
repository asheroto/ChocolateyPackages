$ErrorActionPreference = 'Stop'
$packageName = 'intel-rst-driver'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://downloadmirror.intel.com/773229/SetupRST.exe'
#                                                ^^^^^ is what changes with the version
$checksum = 'A2B2E20D6D8100E9EE344746F80849524C64490B90686A13C09268CADB976B37'

$packageArgs = @{
	packageName    = $packageName
	unzipLocation  = $toolsDir
	fileType       = 'EXE'
	url            = $url
	checksum       = $checksum
	checksumType   = 'sha256'
	silentArgs     = '-s /acceptEULA'
	softwareName   = 'Intel(R) Rapid Storage Technology'
	validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs