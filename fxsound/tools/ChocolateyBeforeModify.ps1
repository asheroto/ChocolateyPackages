$ErrorActionPreference = 'Stop'

Get-Process FxSound -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop