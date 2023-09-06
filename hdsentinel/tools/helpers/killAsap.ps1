$ErrorActionPreference = 'Stop'

<#
.SYNOPSIS
    Initiates a listener to terminate a specified process.
.DESCRIPTION
    The function sets a timeout and initiates the KillAttempt function to terminate the process.
.PARAMETER appName
    The name of the process to terminate.
.EXAMPLE
    KillAsap -appName "notepad"
#>
Function KillAsap {
    param (
        [string]$appName
    )
    $timeout = 15 # Timeout duration in seconds
    $timerStart = Get-Date # Initialize timer
    KillAttempt -appName $appName -timeout $timeout -timerStart $timerStart
}

<#
.SYNOPSIS
    Attempts to terminate a given process within a specified timeout.
.DESCRIPTION
    The function tries to find and terminate the specified process. If the process is not found, it retries until the timeout is reached.
.PARAMETER appName
    The name of the process to terminate.
.PARAMETER timeout
    The timeout duration in seconds.
.PARAMETER timerStart
    The time when the timer was started.
.EXAMPLE
    KillAttempt -appName "notepad" -timeout 15 -timerStart (Get-Date)
#>
Function KillAttempt {
    param (
        [string]$appName,
        [int]$timeout,
        [datetime]$timerStart
    )
    $remainingTime = $timeout - ((Get-Date) - $timerStart).TotalSeconds

    # Exit if timeout is reached
    if ($remainingTime -le 0) {
        Write-Output "`nNo process named '$appName' found within timeout. Proceeding."
        return
    }

    # Attempt to terminate the process
    $process = Get-Process -Name $appName -ErrorAction SilentlyContinue

    if ($process) {
        $process | Stop-Process -Force
        Write-Output "'$appName' process terminated. Proceeding."
    } else {
        Write-Output "`rWaiting for '$appName' to appear. Time remaining: ${remainingTime}s"
        Start-Sleep -Milliseconds 250
        KillAttempt -appName $appName -timeout $timeout -timerStart $timerStart
    }
}