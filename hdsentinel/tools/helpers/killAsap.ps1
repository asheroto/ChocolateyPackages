# ====================================================
# KillAsap
# ====================================================
# Iniates Kill Listener
#
# @param   {string}    Process Name
# @return  {void}
# ====================================================
Function KillAsap([string]$appName) {
    $timeout = 15 #seconds

    KillAttempt $appName $timeout
}

# ====================================================
# KillAttempt
# ====================================================
# Check for given process and try to kill it.
# If it doesn't exists, retry after specific delay.
# If retries exceed max allowed duration, give up.
#
# @param   {string}    Process Name
# @param   {int}       Timeout [s]
# @return  {void}
# ====================================================
Function KillAttempt([string]$appName, [int]$timeout) {
    $countdown = $timeout - ((Get-Date) - $timerStart).Seconds

    # Exit after $timeout seconds if unseccessful
    if ($countdown -le 0) {
        Write-Output "`nNo '$appName' windows found. Proceeding."
        return;
    }

    # Kill the process if present, otherwise retry
    if ($appName -ne $null) {
        $process = (Get-Process $($appName) 2> $null)

        if (!$process) {
            Write-Output "`rWaiting for '$appName' to spawn its windows: $countdown "
            Start-Sleep -m 250
            KillAttempt $appName $timeout

        } else {
            $process | Stop-Process -force
            Write-Output "'$appName' windows found and closed. Proceeding."

        }

    }
}