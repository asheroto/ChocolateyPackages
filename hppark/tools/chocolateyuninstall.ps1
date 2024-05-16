$ErrorActionPreference = 'Stop'

# Parameters
$shortcutName = 'HP PARK.lnk'
$shortcutPath = [System.IO.Path]::Combine($env:Public, 'Desktop', $shortcutName)

# Remove the desktop shortcut
Remove-Item $shortcutPath -Force -ErrorAction 'SilentlyContinue'