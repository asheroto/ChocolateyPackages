$ErrorActionPreference = "Stop"

$packageArgs = @{
    packageName    = "sftpgo"
    fileType       = "exe"
    $version       = "2.5.4"
    url            = "https://github.com/drakkan/sftpgo/releases/download/v${version}/sftpgo_v${version}_windows_x86_64.exe"
    checksum       = "38AA95A6B7E6044977CBDBDAB86DC9F91FCC40285D10C1E5D432BA78AF498017"
    checksumType   = "sha256"
    silentArgs     = "/VERYSILENT"
    validExitCodes = @(0)
    softwareName   = "SFTPGo"
}

Install-ChocolateyPackage @packageArgs

$DefaultDataPath = Join-Path -Path $ENV:ProgramData -ChildPath "SFTPGo"
$DefaultConfigurationFilePath = Join-Path -Path $DefaultDataPath -ChildPath "sftpgo.json"
$EnvDirPath = Join-Path -Path $DefaultDataPath -ChildPath "env.d"

# `t = tab
Write-Output "---------------------------"
Write-Output ""
Write-Output "If you have never used SFTPGo before, the web administration panel is located here:"
Write-Output "`thttp://localhost:8080/web/admin"
Write-Output ""
Write-Output "Default web administration port:"
Write-Output "`t8080"
Write-Output "Default SFTP port:"
Write-Output "`t2022"
Write-Output ""
Write-Output "Default data location:"
Write-Output "`t$DefaultDataPath"
Write-Output "Default configuration file location:"
Write-Output "`t$DefaultConfigurationFilePath"
Write-Output "Directory to create environment variable files to set custom configurations:"
Write-Output "`t$EnvDirPath"
Write-Output ""
Write-Output "If the SFTPGo service does not start, make sure that TCP ports 2022 and 8080 are"
Write-Output "not used by other services or change the SFTPGo configuration to suit your needs."
Write-Output ""
Write-Output "General information (README) location:"
Write-Output "`thttps://github.com/drakkan/sftpgo"
Write-Output "Getting started guide location:"
Write-Output "`thttps://github.com/drakkan/sftpgo/blob/v${version}/docs/howto/getting-started.md"
Write-Output "Detailed information (docs folder) location:"
Write-Output "`thttps://github.com/drakkan/sftpgo/tree/v${version}/docs"
Write-Output ""
Write-Output "---------------------------"
