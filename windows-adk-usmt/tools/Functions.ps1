$ErrorActionPreference = 'Stop'
function Get-WindowsAdkPath {
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
            throw "Unable to find the Path to ADK - remove the path manually"
        }
    } else {
        return Join-Path -Path $KitsRoot -ChildPath "Assessment and Deployment Kit"
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