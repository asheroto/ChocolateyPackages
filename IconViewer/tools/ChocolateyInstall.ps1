$ErrorActionPreference = 'Stop'
$packageName = 'iconviewer'
$softwareName = 'IconViewer*'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$checksum = '2eb365ea3e2f20848206b0b1835c58cc71e2aca1323a19319896b3c8e3bf3956'		
$checksum64 = '3be3664cfac0b9270da161c2c4c323499b4fe40a8e68a2d34cd4425b12ef223f'		
$silentArgs = '/quiet'
$validExitCodes = @(0)
$fileLocation = "$toolsPath\IconViewer3.02-Setup-x86.exe"
$fileLocation64 = "$toolsPath\IconViewer3.02-Setup-x64.exe"

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    file           = $fileLocation
    file64         = $fileLocation64
    checksum       = $checksum
    checksum64     = $checksum64
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
    silentArgs     = $silentArgs
    validExitCodes = $validExitCodes
    softwareName   = $softwareName
}
 
Install-ChocolateyPackage @packageArgs