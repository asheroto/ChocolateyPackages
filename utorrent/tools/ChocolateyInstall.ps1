# uTorrent installer installs unwanted/questionable software by default, which can trigger A/V detections and is against the Chocolatey packaging guidelines.
# This package installs uTorrent without the additional software. See VERIFICATION.txt for more information.

# Define vars
$ErrorActionPreference 	= "Stop"
$packageName 			= "uTorrent"
$softwareName 			= "uTorrent*"
$fileName 				= "uTorrent_3.6.0.46830.exe"
$toolsPath 				= Split-Path $MyInvocation.MyCommand.Definition
$fileLocation 			= "$toolsPath\$fileName"
$checksum 				= "A0BEC6475244F461D3DD822A33038C34F897CB7FE66A0DB930AC859DD810F8AB"
$silentArgs 			= "/S"
$validExitCodes 		= @(0)

# Define package args
$packageArgs = @{
	packageName    = $packageName
	fileType       = "exe"
	file           = $fileLocation
	checksum       = $checksum
	checksumType   = "sha256"
	silentArgs     = $silentArgs
	validExitCodes = $validExitCodes
	softwareName   = $softwareName
}

# Install package
Install-ChocolateyPackage @packageArgs

##################################################################################
########## Close the main uTorrent screen that pops up after installing ##########
##################################################################################

# Over a span of 10 seconds, check every second for the process. If found (and not in $env:TEMP, which is the installer),
# attempt to close its window before a timeout occurs.

# Wait a second
Start-Sleep -Seconds 1

# Define vars
$timeoutSeconds = 10
$counter = 0
$windowClosedSuccessfully = $false

Write-Output "Attempting to close $packageName window."
while ($counter -lt $timeoutSeconds) {
    # Try to find the process, except the one in $env:TEMP
    $processes = Get-Process -Name $packageName -ErrorAction SilentlyContinue | Where-Object { $_.Path -ne $null -and $_.Path -notlike "$env:TEMP\*" }

    # Iterate over each process and attempt to close its window
    foreach($process in $processes){
        try {
            # Attempt to close the window
            $process.CloseMainWindow() | Out-Null
            Start-Sleep -Seconds 1
            $process.Refresh()

            # Check if the window is successfully closed
            if ($process.MainWindowHandle -eq 0) {
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