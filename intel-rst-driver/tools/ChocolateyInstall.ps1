$ErrorActionPreference = 'Stop'

function Get-IntelProcessorGeneration {
    <#
    .SYNOPSIS
        Returns the generation number of the Intel processor.
    .DESCRIPTION
        Returns the generation number of the Intel processor by parsing the processor name.
        More information: https://www.intel.com/content/www/us/en/support/articles/000032203/processors/intel-core-processors.html
    .EXAMPLE
        PS C:\> Get-IntelProcessorGeneration
    #>
    $ProcessorInfo = (Get-CimInstance -ClassName Win32_Processor).Name

    if ($ProcessorInfo -match 'i\d+-\d+') {
        $procMatch = $matches[0]
        $genString = $procMatch.Split('-')[1]

        if ($genString.Length -eq 4) {
            # If it's a 4 digit number after the dash, get the first number
            $generationNumber = [int]($genString.Substring(0, 1))
        } elseif ($genString.Length -eq 5) {
            # If it's a 5 digit number after the dash, get the first two numbers
            $generationNumber = [int]($genString.Substring(0, 2))
        } else {
            return -1
        }

        return $generationNumber
    } else {
        return -1
    }
}

# Variables
$gen = Get-IntelProcessorGeneration
$packageName = 'intel-rst-driver'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksumType = 'sha256'

# Determine which version to download based on the processor generation
switch ($gen) {
    # In November 2023 Intel removed the info URL and download URL for the 7th generation driver. This section may be removed in the future.
    # 7 {
    #     $infoUrl = 'https://www.intel.com/content/www/us/en/download/15667/intel-rapid-storage-technology-intel-rst-user-interface-and-driver.html'
    #     $version = '16.8.5.1014.5'
    #     $url = 'https://downloadmirror.intel.com/773231/SetupRST.exe'
    #     $checksum = '11E737935F85721A6729F52AE1E4D3641DC738168FA3CC1BF1506D198F966AA6'
    # }
    { $_ -in 8, 9 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/19755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-8th-and-9th-gen-platforms.html'
        $version = '17.11.3.1010.2'
        $url = 'https://downloadmirror.intel.com/773230/SetupRST.exe'
        $checksum = 'BC077F9C784305330DF66195FF8C96FCE753B1E370189A6E036005B9E589F7AD'
    }
    { $_ -in 10, 11 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/19512/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-10th-and-11th-gen-platforms.html'
        $version = '18.7.6.1010.3'
        $url = 'https://downloadmirror.intel.com/773229/SetupRST.exe'
        $checksum = 'A2B2E20D6D8100E9EE344746F80849524C64490B90686A13C09268CADB976B37'
    }
    { $_ -in 12, 13 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/849933/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-12th-to-13th-gen-platforms.html'
        $version = '19.5.8.1059.2'
        $url = 'https://downloadmirror.intel.com/849934/SetupRST.exe'
        $checksum = '8AF488ECD76258A0A539ADA28098A2961472D670572900AED216F48C712BC45B'
    }
    { $_ -in 14, 15 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/849936/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-12th-to-15th-gen-platforms.html'
        $version = '20.2.1.1016.4'
        $url = 'https://downloadmirror.intel.com/849939/SetupRST.exe'
        $checksum = '700C403E23AE3F7CEF9581A431D8F6DCB8C6A48F895725E114131C3A29232C99'
    }
    default {
        throw "Unsupported processor generation $gen."
    }
}

# Check if Intel RST is already installed and compare versions
# Only compare the first four segments (x.x.x.x), as stored in the registry
try {
    $regPath = 'HKLM:\SOFTWARE\Intel\IRST'
    $installed = Get-ItemProperty -Path $regPath -Name 'Version' -ErrorAction SilentlyContinue

    if ($null -ne $installed -and $null -ne $version) {
        $installedVersion = ($installed.Version -split '\.')[0..3] -join '.'
        $targetVersion = ($version -split '\.')[0..3] -join '.'

        if (-not [string]::IsNullOrWhiteSpace($installedVersion) -and -not [string]::IsNullOrWhiteSpace($targetVersion)) {
            if ([version]$installedVersion -ge [version]$targetVersion) {
                return "Intel RST version $installedVersion is already installed or newer."
            }
        } else {
            throw "Version comparison failed: one or both version values are empty."
        }
    } else {
        throw "Unable to retrieve version info: registry or input version missing."
    }
} catch {
    throw "Intel RST version check failed: $_"
}

# Package arguments
$packageArgs = @{
    packageName    = $packageName
    unzipLocation  = $toolsDir
    fileType       = 'EXE'
    url            = $url
    checksum       = $checksum
    checksumType   = $checksumType
    silentArgs     = '-silent -accepteula'
    softwareName   = 'Intel(R) Rapid Storage Technology'
    validExitCodes = @(0, 3010, 1641)
}

# Output
Write-Output "---------------------------"
Write-Output ""
Write-Output "Intel RST version $version will be installed for generation $gen."
Write-Output ""
Write-Output "More information about the driver can be found here:"
Write-Output "$infoUrl"
Write-Output ""
Write-Output "---------------------------"

# Install
Install-ChocolateyPackage @packageArgs

# Output
Write-Output "---------------------------"
Write-Output ""
Write-Output "Intel recommends that you restart the computer after installing the driver."
Write-Output ""
Write-Output "---------------------------"