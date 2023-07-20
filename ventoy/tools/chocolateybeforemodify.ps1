$ErrorActionPreference = "Stop";

# Stop-Process won't error if the process doesn't exist
Get-Process Ventoy2Disk -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop
Get-Process VentoyPlugson -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop