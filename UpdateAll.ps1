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
./TablePlus/update.ps1
# ./recuva/update.ps1
./nvm.install/update.ps1
./metadataplusplus/update.ps1
./proxyman/update.ps1
./netscan.install/update.ps1
./hdsentinel/update.ps1
./logitech-options-plus/update.ps1
./httptoolkit/update.ps1

# Return
Pop-Location