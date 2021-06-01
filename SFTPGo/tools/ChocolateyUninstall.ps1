$bits = Get-ProcessorBits

Stop-Service 'sftpgo'

if ($bits -eq 64) {
    $ProgFiles = ${ENV:ProgramFiles}
} else {
    $ProgFiles = ${ENV:ProgramFiles(x86)}
}

Start-Process -FilePath "$ProgFiles\SFTPGo\unins000.exe" -ArgumentList { "/VERYSILENT" }