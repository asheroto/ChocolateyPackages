$ErrorActionPreference	= 'Stop';

Get-Process iVentoy_64 -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop