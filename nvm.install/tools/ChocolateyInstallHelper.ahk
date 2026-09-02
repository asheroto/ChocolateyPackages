; Clicks "Yes" on the NVM for Windows v2 installer's "existing installation detected" prompt.
; The installer shows it with a plain Inno MsgBox, which /SUPPRESSMSGBOXES does not suppress.
; Upstream issue: https://github.com/nvm-windows/nvm/issues/1386
; Log: %TEMP%\nvm-install-helper.log (Chocolatey points TEMP at %TEMP%\chocolatey during installs)

logFile := A_Temp "\nvm-install-helper.log"
Log(msg) {
    global logFile
    line := FormatTime(, "yyyy-MM-dd HH:mm:ss") " " msg
    OutputDebug(line)
    try FileAppend(line "`n", logFile)
}

; Match the dialog by its text, not its title, so the Inno caption does not matter
dialog := "ahk_class #32770"
text := "An existing NVM for Windows installation was detected"

; Installer process names, passed by ChocolateyInstall.ps1. Inno runs the UI in a .tmp child process.
setupExe := A_Args.Length >= 1 ? A_Args[1] : "nvm-setup.exe"
setupTmp := RegExReplace(setupExe, "\.exe$", ".tmp")
started := A_TickCount
clicks := 0

; Find the button whose caption is "Yes" (Inno/MessageBox captions carry an accelerator: "&Yes")
FindYesButton(hwnd) {
    captions := ""
    yes := ""
    for classNN in WinGetControls("ahk_id " hwnd)
    {
        if !(classNN ~= "^Button")
            continue
        caption := ""
        try caption := ControlGetText(classNN, "ahk_id " hwnd)
        captions .= classNN "='" caption "' "
        if (yes = "" && RegExReplace(caption, "&") ~= "i)^Yes$")
            yes := classNN
    }
    Log("Buttons: " captions)
    return yes
}

Log("Script started, PID " ProcessExist() ", watching " setupExe)
Loop
{
    try
    {
        if WinWait(dialog, text, 1)
        {
            hwnd := WinExist(dialog, text)
            if hwnd
            {
                owner := ""
                try owner := ProcessGetName(WinGetPID("ahk_id " hwnd))
                Log("Prompt found, hwnd " hwnd ", title '" WinGetTitle("ahk_id " hwnd) "', owner " owner)
                yes := FindYesButton(hwnd)
                if (yes = "")
                {
                    Log("No Yes button found, leaving the dialog alone")
                    Sleep 1000
                }
                else
                {
                    WinActivate("ahk_id " hwnd)
                    ; Try a click, then BM_CLICK, then Alt+Y, stopping as soon as the dialog closes
                    Log("Clicking " yes)
                    try ControlClick(yes, "ahk_id " hwnd)
                    if !WinWaitClose("ahk_id " hwnd, , 1)
                    {
                        Log("Sending BM_CLICK to " yes)
                        try SendMessage(0x00F5, 0, 0, yes, "ahk_id " hwnd)
                        if !WinWaitClose("ahk_id " hwnd, , 1)
                        {
                            Log("Sending Alt+Y")
                            try ControlSend("!y", , "ahk_id " hwnd)
                            WinWaitClose("ahk_id " hwnd, , 1)
                        }
                    }
                    clicks++
                    Log("Attempt " clicks ": dialog " (WinExist("ahk_id " hwnd) ? "still open" : "closed"))
                }
            }
            else
                Log("Prompt matched but vanished before it could be handled")
        }
    }
    catch as e
        Log("Error: " e.Message " (line " e.Line ")")

    ; Keep watching until the installer has come and gone (30 s grace for it to start), or 60 minutes
    elapsed := A_TickCount - started
    if (elapsed > 30000 && !ProcessExist(setupExe) && !ProcessExist(setupTmp))
    {
        Log("Installer no longer running, exiting after " clicks " click(s)")
        break
    }
    if (elapsed > 3600000)
    {
        Log("Timeout after 60 minutes, exiting")
        break
    }
}
Log("Script finished")
ExitApp
