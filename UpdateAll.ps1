# Remember location
Push-Location

# Change to script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath

# Update packages
./fxsound/update.ps1
./Clickup-Official/update.ps1
./miro/update.ps1
./StartAllBack/update.ps1
./ventoy/update.ps1
./iventoy/update.ps1
./pdq-deploy/update.ps1
./pdq-inventory/update.ps1
./speedtest/update.ps1

# Return
Pop-Location