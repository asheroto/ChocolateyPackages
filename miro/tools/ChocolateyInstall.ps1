$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = "miro"
    fileType       = "exe"
    url            = "https://desktop.miro.com/platforms/win32-x86/Miro.exe"
    url64          = "https://desktop.miro.com/platforms/win32/Miro.exe"
    checksum       = "A393286F92A1C9D0B7200AF173B5F90D661F3FBEA3A461E8D0AE666260C074CA"
    checksum64     = "9531CAE82A00962C00C2839081D227706284FE0E1D04D092B59456ACAFD723EF"
    checksumType   = "sha256"
    silentArgs     = "/silent"
    validExitCodes = @(0)
    softwareName   = "Miro*"
}

# End process
Get-Process Miro -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs