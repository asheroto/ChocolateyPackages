$ErrorActionPreference = 'Stop'

# Define the Start Menu shortcut path
$programsPath = [System.IO.Path]::Combine($env:ProgramData, 'Microsoft', 'Windows', 'Start Menu', 'Programs')
$programsFilePath = [System.IO.Path]::Combine($programsPath, 'Speedtest CLI.lnk')

# Remove StartMenu shortcut if it exists
if (Test-Path $programsFilePath) {
    Write-Output "Removing Start Menu shortcut..."
    Remove-Item -Path $programsFilePath -Force
} else {
    Write-Output "Start Menu shortcut not found. Skipping removal."
}