$ErrorActionPreference = 'Stop'

Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop