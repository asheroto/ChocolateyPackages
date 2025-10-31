$ErrorActionPreference = "Stop"

# Package args
$packageArgs = @{
    packageName    = 'clickup-official'
    fileType       = 'exe'
    url            = 'https://desktop.clickup.com/windows'
    checksum       = '1E9D68D289EB6C56F79FB8A6D79A36B7690421529080FFF528A59721B0F92ED3'
    checksumType   = 'sha256'
    silentArgs     = '/silent'
    validExitCodes = @(0)
    softwareName   = 'ClickUp*'
}

# End ClickUp process
Get-Process ClickUp -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop

# Install
Install-ChocolateyPackage @packageArgs

##################################################################################
########## Close the main ClickUp screen that pops up after installing ##########
##################################################################################

# Over a span of 10 seconds, check every second for the process. If found (and not in $env:TEMP, which may be the installer),
# attempt to close its window before a timeout occurs.

# Wait a second
Start-Sleep -Seconds 1

# Define vars
$packageName = "ClickUp"
$timeoutSeconds = 10
$counter = 0
$windowClosedSuccessfully = $false

Write-Output "Attempting to close $packageName window..."
while ($counter -lt $timeoutSeconds) {
    # Try to find the process, except the one in $env:TEMP
    $processes = Get-Process -Name $packageName -ErrorAction SilentlyContinue | Where-Object { $_.Path -ne $null -and $_.Path -notlike "$env:TEMP\*" }

    # Iterate over each process and attempt to close its window
    foreach ($process in $processes) {
        try {
            if ($process.MainWindowHandle -ne 0) {
                Write-Output "Closing $packageName window..."

                # Attempt to close the window
                $process.CloseMainWindow() | Out-Null
                Start-Sleep -Seconds 1
                $process.Refresh()

                Write-Output "$packageName window has been closed successfully."
                $windowClosedSuccessfully = $true
                break
            }
        } catch {
            Write-Warning "An error occurred trying to close the $packageName window: $_. Will try again."
        }
    }

    # If the window was closed successfully, break out of the outer loop as well
    if ($windowClosedSuccessfully) {
        break
    }

    # Wait a second before next attempt
    Start-Sleep -Seconds 1

    # Increase the counter
    $counter++
}

if (-not $windowClosedSuccessfully) {
    Write-Warning "The $packageName window could not be closed within $timeoutSeconds seconds."
}