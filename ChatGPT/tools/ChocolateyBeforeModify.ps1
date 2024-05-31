$ErrorActionPreference = 'Stop'

Get-Process ChatGPT -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop