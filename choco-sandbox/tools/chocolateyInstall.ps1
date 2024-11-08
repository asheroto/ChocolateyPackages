$ErrorActionPreference = 'Stop'
$packageName  = 'choco-sandbox'
$shortcutName = 'Chocolatey Sandbox.lnk'
$scriptDir    = "$(Get-ToolsLocation)\BCURRAN3\choco-sandbox"
$script       = 'choco-sandbox.ps1'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$toolsDir\choco-sandbox.wsb"

Confirm-WinMinimumBuild 18305

# Update the WSB (config) file if the Chocolatey Tools Location is non-default
if ($(Get-ToolsLocation) -ne "C:\tools"){
	[xml]$WSBConfig = Get-Content "$exe"
    $WSBConfig.Configuration.MappedFolders.MappedFolder.HostFolder = "$scriptDir"
    Write-Host "  ** Updating WSB file with your defined Chocolatey tools dir." -Foreground Magenta
	$WSBConfig.Save("$exe")
}

# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$(Get-ToolsLocation)\BCURRAN3")) { New-Item -Path "$(Get-ToolsLocation)" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }
if (!(Test-Path "$(Get-ToolsLocation)\BCURRAN3\choco-sandbox")) { New-Item -Path "$(Get-ToolsLocation)\BCURRAN3" -Name "choco-sandbox" -ItemType "Directory" | Out-Null }

# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\$exe" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\choco-sandbox-customize.ps1.example" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\Microsoft.PowerShell_profile.ps1" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\packages.config.example" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\ReadMe.txt" "$scriptDir" -Force -ErrorAction SilentlyContinue

# Make shortcuts
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -IconLocation "$toolsDir\Chocolatey Sandbox.ico" -RunAsAdmin
if (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
    Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath $exe  -IconLocation "$toolsDir\Chocolatey Sandbox.ico" -RunAsAdmin
   } else {
     Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe  -IconLocation "$toolsDir\Chocolatey Sandbox.ico" -RunAsAdmin
    }
