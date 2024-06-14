$ErrorActionPreference = 'Stop'

# Close main window instead of kill to avoid port in use errors
(Get-Process -Name "HTTP Toolkit" -ErrorAction SilentlyContinue).CloseMainWindow()