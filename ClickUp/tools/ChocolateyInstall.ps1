$packageName    = 'ClickUp'
$softwareName   = 'ClickUp'
$url            = 'https://github.com/asheroto/ClickUp/releases/download/0.0.6.1/ClickUp.exe'
$checksum       = '2E4C1729E714863079C025100301900409D40EE4F04091B41204EC52604280B6'
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