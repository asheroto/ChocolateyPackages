; OutbutDebug can be read by DebugView (https://docs.microsoft.com/en-us/sysinternals/downloads/debugview)
OutputDebug("Script started")

; Wait for the "StartAllBack configuration" window to become active
OutputDebug("Waiting for the StartAllBack configuration window...")
if !WinWait("StartAllBack configuration", "", 10)
{
    OutputDebug("WinWait timed out. Window not found.")
    ExitApp
}
OutputDebug("StartAllBack configuration window found.")
WinActivate("StartAllBack configuration")
OutputDebug("StartAllBack configuration window activated.")

; Use ControlClick to select "Proper 11" using ClassNN TButton3
if ControlClick("TButton3", "StartAllBack configuration")
{
    OutputDebug("ControlClick on Proper 11 successful.")
}
else
{
    OutputDebug("ControlClick on Proper 11 failed.")
}

; Close the window
WinClose("StartAllBack configuration")
OutputDebug("Window closed.")