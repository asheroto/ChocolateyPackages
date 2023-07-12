$ErrorActionPreference	= "Stop"

# Stop uTorrent before anything else
Get-Process uTorrent -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop