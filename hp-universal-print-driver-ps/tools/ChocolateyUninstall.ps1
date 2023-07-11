$ErrorActionPreference = 'Stop'

# Define driver name
$driverName = 'HP Universal Printing PS'

# Restart spooler service to avoid "The specified printer driver is currently in use" error
Restart-Service -Name Spooler -Force

# Remove printers using that driver
Get-Printer | ? { $_.DriverName -eq $driverName } | Remove-Printer

# Remove driver
Remove-PrinterDriver "HP Universal Printing PS"

# Notify user that the driver has been removed
Write-Output "---------------------------"
Write-Output ""
Write-Output "Printers using the $driverName driver have been removed. This is required to remove the driver."
Write-Output ""
Write-Output "The $driveName driver have been removed."
Write-Output ""
Write-Output "---------------------------"