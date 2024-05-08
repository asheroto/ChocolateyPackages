$ErrorActionPreference = 'Stop'

Get-Process netscan -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop