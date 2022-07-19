Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Script -Name winget-install -Repository PSGallery -Force
winget-install

Write-Output "---------------------------------------"
Write-Output "You will probably need to restart the comptuer in order for winget to work"
Write-Output "After restarting, simply type ""winget"" to use"
Write-Output "---------------------------------------"