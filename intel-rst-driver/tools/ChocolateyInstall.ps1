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
    7 {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/15667/intel-rapid-storage-technology-intel-rst-user-interface-and-driver.html'
        $version = '16.8.5.1014.5'
        $url = 'https://downloadmirror.intel.com/773231/SetupRST.exe'
        $checksum = '11E737935F85721A6729F52AE1E4D3641DC738168FA3CC1BF1506D198F966AA6'
    }
    { $_ -in 8, 9 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/19755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-8th-and-9th-gen-platforms.html'
        $version = '17.11.3.1010.2'
        $url = 'https://downloadmirror.intel.com/773230/SetupRST.exe'
        $checksum = 'BC077F9C784305330DF66195FF8C96FCE753B1E370189A6E036005B9E589F7AD'
    }
    { $_ -in 10 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/19512/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-10th-and-11th-gen-platforms.html'
        $version = '18.7.6.1010.3'
        $url = 'https://downloadmirror.intel.com/773229/SetupRST.exe'
        $checksum = 'A2B2E20D6D8100E9EE344746F80849524C64490B90686A13C09268CADB976B37'
    }
    { $_ -in 11, 12, 13 } {
        $infoUrl = 'https://www.intel.com/content/www/us/en/download/720755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-11th-and-12th-gen-platforms.html'
        $version = '19.5.2.1049.5'
        $url = 'https://downloadmirror.intel.com/751275/SetupRST.exe'
        $checksum = 'F671E1CBBD4313C40878A1AD6F4152585D0E10192CBAD39274E9D5EBE7276FE7'
    }
    default {
        throw "Unsupported processor generation $gen."
    }
}

# If the package is already installed, return error
# Read HKEY_LOCAL_MACHINE\SOFTWARE\Intel\IRST\Version for the installed version
# If the installed version is the same as or newer than the version to install, throw error
# Don't match the last number in the version string, only x.x.x.x as that is what is in the registry
try {
    $installedVersion = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Intel\IRST' -Name 'Version' -ErrorAction SilentlyContinue
    if ($installedVersion -and $version) {
        $installedVersion = $installedVersion.Version
        $installedVersionSegments = $installedVersion -split '\.'
        $versionSegments = $version -split '\.'

        # Take only the first four segments for comparison
        $installedMainVersion = [string]::Join('.', $installedVersionSegments[0..3])
        $mainVersionToInstall = [string]::Join('.', $versionSegments[0..3])

        # Only perform the comparison if variables are not empty
        if (-not [string]::IsNullOrEmpty($installedMainVersion) -and -not [string]::IsNullOrEmpty($mainVersionToInstall)) {
            if ([version]$installedMainVersion -ge [version]$mainVersionToInstall) {
                return "Intel RST version $installedMainVersion is already installed."
            }
        } else {
            throw "Cannot detect installed version of Intel RST. One or both version variables are empty."
        }
    } else {
        throw "Cannot detect installed version of Intel RST."
    }
} catch {
    throw "An error occurred when checking Intel RST version: $_"
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