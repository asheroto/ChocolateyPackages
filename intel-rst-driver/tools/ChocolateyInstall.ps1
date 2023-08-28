$ErrorActionPreference = 'Stop'

function Get-IntelProcessorGeneration {
    <#
    .SYNOPSIS
        Returns the generation number of the Intel processor.
    .DESCRIPTION
        Returns the generation number of the Intel processor by parsing the processor name per https://www.intel.com/content/www/us/en/support/articles/000032203/processors/intel-core-processors.html
    .EXAMPLE
        PS C:\> Get-IntelProcessorGeneration
    #>
    $ProcessorInfo = (Get-CimInstance -ClassName Win32_Processor).Name

    if ($ProcessorInfo -match 'i\d+-\d+') {
        $procMatch = $matches[0]
        $generationNumber = [int]($procMatch.Split('-')[1].Substring(0, 2))
        return $generationNumber
    } else {
        return -1
    }
}

$gen = Get-IntelProcessorGeneration
$packageName = 'intel-rst-driver'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

switch ($gen) {
    7 {
        # https://www.intel.com/content/www/us/en/download/15667/intel-rapid-storage-technology-intel-rst-user-interface-and-driver.html
        $url = 'https://downloadmirror.intel.com/773231/SetupRST.exe'
        $checksum = '11E737935F85721A6729F52AE1E4D3641DC738168FA3CC1BF1506D198F966AA6'
    }
    { $_ -in 8, 9 } {
        # https://www.intel.com/content/www/us/en/download/19755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-8th-and-9th-gen-platforms.html
        $url = 'https://downloadmirror.intel.com/773230/SetupRST.exe'
        $checksum = 'BC077F9C784305330DF66195FF8C96FCE753B1E370189A6E036005B9E589F7AD'
    }
    { $_ -in 10, 11 } {
        # https://www.intel.com/content/www/us/en/download/19512/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-10th-and-11th-gen-platforms.html
        $url = 'https://downloadmirror.intel.com/773229/SetupRST.exe'
        $checksum = 'A2B2E20D6D8100E9EE344746F80849524C64490B90686A13C09268CADB976B37'
    }
    { $_ -ge 12 -and $_ -le 13 } {
        # May need to adjust this for 11th-13th, waiting to hear back from Intel
        # May need to adjust this for 11th-13th, waiting to hear back from Intel
        # May need to adjust this for 11th-13th, waiting to hear back from Intel
        # May need to adjust this for 11th-13th, waiting to hear back from Intel
        # May need to adjust this for 11th-13th, waiting to hear back from Intel
        # https://www.intel.com/content/www/us/en/download/720755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-11th-and-12th-gen-platforms.html
        $url = 'https://downloadmirror.intel.com/751275/SetupRST.exe'
        $checksum = 'F671E1CBBD4313C40878A1AD6F4152585D0E10192CBAD39274E9D5EBE7276FE7'
    }
    default {
        throw "Unsupported processor generation."
    }
}

$packageArgs = @{
    packageName    = $packageName
    unzipLocation  = $toolsDir
    fileType       = 'EXE'
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    silentArgs     = '-s /acceptEULA'
    softwareName   = 'Intel(R) Rapid Storage Technology'
    validExitCodes = @(0, 3010, 1641)
}

# Output
Write-Output "Intel RST will be installed for generation $gen."
Write-Output "URL: $url"
Write-Output "Checksum: $checksum"
#Install-ChocolateyPackage @packageArgs