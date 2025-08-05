$ErrorActionPreference = 'Stop'

# Download
# https://support.hp.com/us-en/drivers/hp-universal-print-driver-series-for-windows/model/3271558
# Using the link from the download button won't work for scraping the version number due to the HP website.
# Using VisualPing to monitor the version as it supports clicking. Check ran weekly.

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = "7.8.0.26261"

$packageArgs = @{
    packageName    = 'hp-universal-print-driver-ps'
	url            = "https://ftp.hp.com/pub/softlib/software13/UPD/upd-ps-x64-${version}.zip"
    checksum       = '84D89A5A040B5BFA8ED06B281667178512C9FDAF533FC5921A34C1CAE321D3E8'
    softwareName   = 'HP Universal Printing PS'
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