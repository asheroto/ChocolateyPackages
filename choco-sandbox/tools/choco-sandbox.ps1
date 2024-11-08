# Choco-Sandbox.ps1 Copyleft 2023-2024 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

Clear-Host
Write-Host "Choco-Sandbox.ps1 v1.0.1 (2024-08-25) - Sets up Windows Sandbox with Chocolatey Installed" -Foreground White
Write-Host "Copyleft 2023-2024 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

$InstalledFromWeb=$False

# Allow all scripts to run since its a sandbox
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# Add PowerShell profile with Chocolatey tab completion
if (!(Test-Path "C:\Users\WDAGUtilityAccount\Documents\WindowsPowerShell")) { New-Item -Path "C:\Users\WDAGUtilityAccount\Documents" -Name "WindowsPowerShell" -ItemType "Directory" | Out-Null }
Copy-Item "C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\Microsoft.PowerShell_profile.ps1" "C:\Users\WDAGUtilityAccount\Documents\WindowsPowerShell\"

# Install Chocolatey from previously downloadeded file so we don't skew the download count too much for Rob and the boys
if (Test-Path C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey.zip){
	Write-Host "  ** Installing Chocolatey from cached download." -Foreground Magenta
	Expand-Archive C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey.zip -DestinationPath C:\Windows\Temp\chocolatey -Force | Out-Null
	C:\Windows\Temp\chocolatey\tools\chocolateyInstall.ps1  | Out-Null
	Copy-Item C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey.zip C:\ProgramData\chocolatey\lib\chocolatey\chocolatey.nupkg
	Copy-Item C:\Windows\Temp\chocolatey\chocolatey.nuspec C:\ProgramData\chocolatey\lib\chocolatey
#	Remove-Item C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey -Recurse -Force
} else {
# Install Chocolatey from the web
    Write-Host "  ** Installing Chocolatey from the web." -Foreground Magenta
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
# Save chocolatey.zip for future use so we don't have to continuously download it
    Copy-Item C:\ProgramData\chocolatey\lib\chocolatey\chocolatey.nupkg C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey.zip -Force
	$InstalledFromWeb=$True
}

# Upgrade Chocolatey if outdated
if (!($InstalledFromWeb)){
	Write-Host "  ** Making sure Chocolatey is up-to-date..." -Foreground Magenta
    choco upgrade chocolatey -y
    Copy-Item C:\ProgramData\chocolatey\lib\chocolatey\chocolatey.nupkg C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\chocolatey.zip -Force
}

# Install packages
if (Test-Path C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\packages.config){
	Write-Host "  ** Installing packages from packages.config..." -Foreground Magenta
	choco install C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\packages.config -y
} else {
	if (Test-Path C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\packages.config.example){
		Write-Host "  ** HINT: Rename packages.config.example to packages.config and edit to have packages automatically installed." -Foreground Cyan
	}
}

# Load Chocolatey PowerShell profile
. $profile

# Run custom script
if (Test-Path C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\choco-sandbox-customize.ps1){
	Write-Host "  ** Running choco-sandbox-customize.ps1..." -Foreground Magenta
	& C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\choco-sandbox-customize.ps1 -ErrorActtion SilentlyContinue
} else {
	if (Test-Path C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox\choco-sandbox-customize.ps1.example){
		Write-Host "  ** HINT: Rename choco-sandbox-customize.ps1.example to choco-sandbox-customize.ps1 and edit to script anything else you want automated." -Foreground Cyan
	}
}

Set-Location "C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox"

Write-Host "`nGo Go Chocolatey Go!" -Foreground White
Write-Host "`nFound Chocolatey Sandbox useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White