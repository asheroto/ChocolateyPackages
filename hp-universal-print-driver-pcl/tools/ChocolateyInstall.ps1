$ErrorActionPreference = 'Stop'

# Download
# https://support.hp.com/us-en/drivers/hp-universal-print-driver-series-for-windows/model/3271558
# Using the link from the download button won't work for scraping the version number due to the HP website.
# Using VisualPing to monitor the version as it supports clicking. Check ran weekly.

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = "8.2.0.26778"

$packageArgs = @{
	packageName    = 'hp-universal-print-driver-pcl'
	url            = "https://ftp.hp.com/pub/softlib/software13/printers/UPD/upd-pcl6-win10-x64-${version}.zip"
	checksum       = '0D6DE14AE6FD549B6028AC38231B625B96F6A525A585950016AD295D97E10210'
	softwareName   = 'HP Universal Printing PCL 6'
	fileLocation   = "$toolsDir\unzippedfiles\install.exe"
	unzipLocation  = "$toolsDir\unzippedfiles"
	fileType       = 'ZIP'
	checksumType   = 'sha256'
	url64          = $url
	checksum64     = $checksum
	checksumType64 = 'sha256'
}

# Make sure Print Spooler service is up and running
try {
	$serviceName = 'Spooler'
	$spoolerService = Get-CimInstance -ClassName Win32_Service -Property StartMode, State -Filter "Name='$serviceName'"
	if ($null -eq $spoolerService) { throw "Service $serviceName was not found" }
	Write-Output "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
	if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
		Set-Service $serviceName -StartupType Automatic -Status Running
		Write-Output 'Print Spooler service new state: Auto / Running'
	}
} catch {
	Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

New-Item $packageArgs.unzipLocation -Type directory | Out-Null

Install-ChocolateyZipPackage @packageArgs

$installArgs = @{
	packageName    = $packageArgs.packageName
	fileType       = 'EXE'
	file           = $packageArgs.fileLocation
	silentArgs     = '/dm /nd /npf /q /h'
	validExitCodes = @(0, 3010, 1641)
	softwareName   = $packageArgs.softwareName
}

Install-ChocolateyInstallPackage @installArgs

Remove-Item "$toolsDir\unzippedfiles" -Recurse | Out-Null