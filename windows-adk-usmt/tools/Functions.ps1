$ErrorActionPreference = 'Stop'
function Get-WindowsAdkPath {
    <#
        .SYNOPSIS
        Gets the path to the Windows Assessment and Deployment Kit.

        .DESCRIPTION
        Gets the path to the Windows Assessment and Deployment Kit by checking the registry for the KitsRoot value and by checking the filesystem for the path.

        .EXAMPLE
        Get-WindowsAdkPath
    #>
    $KitsRootRegPaths = @(
        'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Kits\Installed Roots',
        'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Kits\Installed Roots'
    )
    $Keys = @('KitsRoot11', 'KitsRoot10')
    $KitsRoot = $null

    # Loop through the registry keys until we find the KitsRoot value
    foreach ($Path in $KitsRootRegPaths) {
        $KitsRootKey = Get-Item -Path $Path -ErrorAction SilentlyContinue
        if ($KitsRootKey -is [Microsoft.Win32.RegistryKey]) {
            foreach ($Key in $Keys) {
                $KitsRoot = $KitsRootKey.GetValue($Key)
                if ($null -ne $KitsRoot) {
                    break
                }
            }
        }
        if ($null -ne $KitsRoot) {
            break
        }
    }

    # If KitsRoot is null, try to find the path to ADK from the filesystem
    if ($null -eq $KitsRoot) {
        $PossibleADKPath1 = Join-Path -Path ${env:ProgramFiles(x86)} -ChildPath "Assessment and Deployment Kit"
        $PossibleADKPath2 = Join-Path -Path $env:ProgramFiles -ChildPath "Assessment and Deployment Kit"

        if (Test-Path -Path $PossibleADKPath1 -ErrorAction Ignore) {
            return $PossibleADKPath1
        } elseif (Test-Path -Path $PossibleADKPath2 -ErrorAction Ignore) {
            return $PossibleADKPath2
        } else {
            throw $null
        }
    } else {
        return Join-Path -Path $KitsRoot -ChildPath "Assessment and Deployment Kit"
    }
}

function Get-USMTPath {
    <#
        .SYNOPSIS
        Returns the directory that scanstate/loadstate is in. Returns $null if directory is not found.

        .DESCRIPTION
        Returns the directory that scanstate/loadstate is in. Returns $null if directory is not found.

        .EXAMPLE
        Get-USMTPath
    #>
    $adkPath = Get-WindowsAdkPath
    if ($null -ne $adkPath) {
        # Build the path to the User State Migration Tool
        $usmtPath = Join-Path -Path $adkPath -ChildPath "User State Migration Tool\$($env:PROCESSOR_ARCHITECTURE)"

        # Build the path to the scanstate.exe
        $scanstatePath = Join-Path -Path $usmtPath -ChildPath "scanstate.exe"

        # Verify that the scanstate.exe exists
        if (Test-Path -Path $scanstatePath -ErrorAction SilentlyContinue) {
            # Return the path that scanstate.exe is in
            return $usmtPath
        } else {
            throw $null
        }
    }
}

function Get-ScanStateStatus {
    <#
        .SYNOPSIS
        Checks if the scanstate command works.

        .DESCRIPTION
        Checks if the scanstate command works.

        .EXAMPLE
        Get-ScanStateStatus
    #>

    # Check if scanstate is working
    $scanstate = Get-Command -Name scanstate -ErrorAction SilentlyContinue

    # If scanstate is installed, return $true
    if ($null -ne $scanstate) {
        return $true
    }

    # If scanstate is not installed, return $false
    return $false
}

function Write-Section($text) {
    <#
        .SYNOPSIS
        Prints a text block surrounded by a section divider for enhanced output readability.

        .DESCRIPTION
        This function takes a string input and prints it to the console, surrounded by a section divider made of hash characters.
        It is designed to enhance the readability of console output.

        .PARAMETER text
        The text to be printed within the section divider.

        .EXAMPLE
        Write-Section "Downloading Files..."
        This command prints the text "Downloading Files..." surrounded by a section divider.
    #>
    Write-Output ""
    Write-Output ("#" * ($text.Length + 4))
    Write-Output "# $text #"
    Write-Output ("#" * ($text.Length + 4))
    Write-Output ""
}

# See this for more info:
# https://stackoverflow.com/questions/4825967/environment-setenvironmentvariable-takes-a-long-time-to-set-a-variable-at-user-o
function Set-EnvironmentVariable {
    <#
        .SYNOPSIS
        Instantly sets an environment variable in the machine or user environment by updating the registry.

        .DESCRIPTION
        Instantly sets an environment variable in the machine or user environment by updating the registry.

        .PARAMETER Name
        The name of the environment variable to set.

        .PARAMETER Value
        The value of the environment variable to set.

        .PARAMETER Target
        The target environment to set the environment variable in. Valid values are 'Machine' and 'User'.

        .EXAMPLE
        Set-EnvironmentVariable -Name "MyVariable" -Value "MyValue" -Target "Machine"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Value,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Machine", "User")]
        [string]$Target
    )

    $regKey = switch ($Target.ToLower()) {
        "machine" { 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' }
        "user" { 'HKCU:\Environment' }
    }

    Set-ItemProperty -Path $regKey -Name $Name -Value $Value
}

function Remove-EnvironmentVariable {
    <#
        .SYNOPSIS
        Instantly removes an environment variable from the machine or user environment by updating the registry.

        .DESCRIPTION
        Instantly removes an environment variable from the machine or user environment by updating the registry.

        .PARAMETER Name
        The name of the environment variable to remove.

        .PARAMETER Target
        The target environment to remove the environment variable from. Valid values are 'Machine' and 'User'.

        .EXAMPLE
        Remove-EnvironmentVariable -Name "MyVariable" -Target "Machine"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_.ToLower() -eq "path") {
                    throw "Cannot remove the 'Path' environment variable for safety reasons."
                }
                return $true
            })]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Machine", "User")]
        [string]$Target
    )

    $regKey = switch ($Target.ToLower()) {
        "machine" { 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' }
        "user" { 'HKCU:\Environment' }
    }

    $existingProperties = Get-Item -Path $regKey | Select-Object -ExpandProperty Property

    if ($existingProperties -contains $Name) {
        # Write-Output "Removing environment variable '$Name' from the $Target environment."
        Remove-ItemProperty -Path $regKey -Name $Name
    } else {
        Write-Warning "Environment variable '$Name' does not exist in the $Target environment."
    }
}

function Get-EnvironmentVariable {
    <#
        .SYNOPSIS
        Retrieves the value of an environment variable from the machine or user environment by accessing the registry.

        .DESCRIPTION
        Retrieves the value of an environment variable from the machine or user environment by accessing the registry.

        .PARAMETER Name
        The name of the environment variable to retrieve.

        .PARAMETER Target
        The target environment to retrieve the environment variable from. Valid values are 'Machine' and 'User'.

        .EXAMPLE
        Get-EnvironmentVariable -Name "MyVariable" -Target "Machine"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Machine", "User")]
        [string]$Target
    )

    $regKey = switch ($Target.ToLower()) {
        "machine" { 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' }
        "user" { 'HKCU:\Environment' }
    }

    $existingProperties = Get-Item -Path $regKey | Select-Object -ExpandProperty Property

    if ($existingProperties -contains $Name) {
        $value = Get-ItemProperty -Path $regKey -Name $Name | Select-Object -ExpandProperty $Name
        return $value
    } else {
        Write-Warning "Environment variable '$Name' does not exist in the $Target environment."
        return $null
    }
}