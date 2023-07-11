$ErrorActionPreference = 'Stop'
$packageName    = 'utorrent'
$installerType  = 'EXE' 
$silentArgs     = '/uninstall /S'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$unpath         = "${Env:AppData}\uTorrent\uTorrent.exe"

Start-CheckandStop "uTorrent"

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes

