$ErrorActionPreference = 'Stop'

# Download
# https://support.hp.com/us-en/drivers/upd/4157320
# Using the link from the download button won't work for scraping the version number due to the HP website.
# Using VisualPing to monitor the version as it supports clicking. Check ran weekly.

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = "7.6.0.26178"

$packageArgs = @{
	packageName    = 'hp-universal-print-driver-pcl'
	url            = "https://ftp.hp.com/pub/softlib/software13/printers/UPD/upd-pcl6-x64-${version}.zip"
	checksum       = '00C03CC11FC58A40D415E95EB60236394C984E0061935146A8E658F847C07E4D'
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

New-Item $packageArgs.fileLocation -Type directory | Out-Null

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