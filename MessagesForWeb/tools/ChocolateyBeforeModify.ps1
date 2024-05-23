$ErrorActionPreference = 'Stop'

Get-Process MessagesForWeb -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop