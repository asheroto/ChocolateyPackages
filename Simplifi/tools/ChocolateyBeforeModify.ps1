$ErrorActionPreference = 'Stop'

Get-Process Simplifi -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop