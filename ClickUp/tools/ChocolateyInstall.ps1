$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.6.1/ClickUp.exe'
$checksum       = '1A48018604FACB00F5BD7602A3F9B638168AD9193136B2D3F982AC79C254A28F'
$silentArgs     = '/quiet'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $fileLocation
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}

# Stop the process
Stop-Process -Name $packageName -ErrorAction SilentlyContinue -Force

# Install the package
Install-ChocolateyPackage @packageArgs