$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'hp-universal-print-driver-ps'
$url            = 'https://ftp.hp.com/pub/softlib/software13/printers/UPD/upd-ps-x32-7.1.0.25570.exe'
$checksum       = '680967E8C32026BC2071CE27A65E55A2E26501F405A8A09C0324F59A974F1CC2'
$url64          = 'https://ftp.hp.com/pub/softlib/software13/printers/UPD/upd-ps-x64-7.1.0.25570.exe'
$checksum64     = 'B5E03EFF7772B8FF14E6BC09E7D3ECE79FDC058AC93E597D4DE58EA65CD131A1'
$softwareName   = ''
$fileLocation   = "$toolsDir\unzippedfiles\install.exe"

# Make sure Print Spooler service is up and running stolen from cutepdf package.
try {
	$serviceName = 'Spooler'
	$spoolerService = Get-CimInstance -ClassName Win32_Service -Property StartMode,State -Filter "Name='$serviceName'"
	if ($null -eq $spoolerService) { throw "Service $serviceName was not found" }
	Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.State)"
	if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.State -ne 'Running') {
		Set-Service $serviceName -StartupType Automatic -Status Running
		Write-Host 'Print Spooler service new state: Auto / Running'
	}
} catch {
	Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

New-Item $fileLocation -Type directory | Out-Null

$packageArgs = @{
	packageName    = $packageName
	unzipLocation  = "$toolsDir\unzippedfiles"
	fileType       = 'ZIP'
	url            = $url
	checksum       = $checksum
	checksumType   = 'sha256'
	url64          = $url64
	checksum64     = $checksum64
	checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
	packageName    = $packageName
	fileType       = 'EXE'
	file           = $fileLocation
	silentArgs     = '/dm /nd /npf /q /h'
	validExitCodes = @(0, 3010, 1641)
	softwareName   = $softwareName
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\unzippedfiles" -Recurse | Out-Null