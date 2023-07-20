$ErrorActionPreference	= "Stop";

# Stop-Process won't error if the process doesn't exist
Get-Process iVentoy_32 -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop
Get-Process iVentoy_64 -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop