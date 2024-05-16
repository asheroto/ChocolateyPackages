$ErrorActionPreference = 'Stop'

# Define driver name
$driverName = 'HP Universal Printing PCL 6'

# Restart spooler service to avoid "The specified printer driver is currently in use" error
Restart-Service -Name Spooler -Force

# Remove printers using that driver
Get-Printer | Where-Object { $_.DriverName -eq $driverName } | Remove-Printer

# Remove driver
Remove-PrinterDriver -Name $driverName

# Notify user that the driver has been removed
$outputMessage = @"
---------------------------
Printers using the $driverName driver have been removed. This is required to remove the driver.

The $driverName driver has been removed.
---------------------------
"@
Write-Output $outputMessage