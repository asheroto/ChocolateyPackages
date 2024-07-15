# Remember location
Push-Location

# Change to script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath

# Update packages
./ChatGPT/update.ps1
./ClickUp/update.ps1                    # Author pushes updates to Chocolatey
./Clickup-Official/update.ps1
./filemenutools/update.ps1
./fxsound/update.ps1
./hdsentinel/update.ps1
./httptoolkit/update.ps1
./iventoy/update.ps1
./laravel-herd/update.ps1
./herd/update.ps1
./logitech-options-plus/update.ps1
./MessagesForWeb/update.ps1
./metadataplusplus/update.ps1
./miro/update.ps1
./netscan.install/update.ps1
./nvm.install/update.ps1
./pdq-deploy/update.ps1
./pdq-inventory/update.ps1
./proxyman/update.ps1
./recuva/update.ps1
./qflipper/update.ps1
#./Simplifi/update.ps1                  # Author pushes updates to Chocolatey
#./SFTPGo/update.ps1                    # Author pushes updates to Chocolatey
./speedtest/update.ps1
./StartAllBack/update.ps1
./TablePlus/update.ps1
./ventoy/update.ps1

# Return
Pop-Location