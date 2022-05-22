$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.6.1/ClickUp.exe'
$checksum       = '635A6174E852E75900027D9479F06C8B90CE09D619A844B55528C974AB25D378'
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
Stop-Process -Name $packageName -ErrorAction SilentlyContinue

# Install the package
Install-ChocolateyPackage @packageArgs