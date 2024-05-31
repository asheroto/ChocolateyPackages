function SendAlertRaw {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Subject,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Note - you might consider using ntfy.sh, it's an awesome tool
    # In this script, however, I'm using a custom service that I built
    # This function gets the URL from a secure string file (encrypted) and sends the alert by making a POST request to the URL
    # If you just want to make a GET/POST request, comment out the lines below until you get to the if($alertUrl)/Invoke-WebRequest section and replace with your own code

    # To save the URL as a secure string, run the following command in the comment block:
    <#
        # Connect
        $CredsFile = "C:\Path\To\SecureString\Folder\SecretURL.txt"

        # Store credential in a file as secure string
        Read-Host "Secret URL" -AsSecureString | ConvertFrom-SecureString | Out-File $CredsFile
    #>

    # Environment variable contains path to $CredsFile (create or change below as needed)
    # Get the secret URL from the secure string file using the path in the environment variable
    $CredsFile = [System.Environment]::GetEnvironmentVariable('EMAIL_NOTIFICATION_CREDS_PATH', [System.EnvironmentVariableTarget]::User)

    # Convert the secure string to a string
    $secret = Get-Content $CredsFile | ConvertTo-SecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret)
    $alertUrl = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    # Replace {SUBJECT} and {MESSAGE} in the URL
    $alertUrl = $alertUrl -replace '{SUBJECT}', $Subject
    $alertUrl = $alertUrl -replace '{MESSAGE}', $Message

    if ($alertUrl) {
        try {
            Invoke-WebRequest -Uri $alertUrl -Method Post -Body $Message -ContentType "text/plain" | Out-Null
            Write-Output "Alert sent."
        } catch {
            Write-Warning "Failed to send alert."
        }
    }
}

function SendAlert {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Subject,

        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [boolean]$Alert = $true
    )

    # If Alert is false, let the user know that the alert is disabled
    if (!$Alert) {
        Write-Output "Alert disabled. Skipping alert."
        return
    }

    # Output sending alert
    Write-Output "Sending alert..."

    # Create the HTML body for the notification
    $date = Get-Date -Format "yyyy-MM-dd hh:mm:ss tt"
    $body = "<html><body>"
    $body += "<font face='Arial'>"
    $body += "<p>$Message</p>"
    $body += "<p><strong>Time:</strong> $date</p>"
    $body += "</font>"
    $body += "</body></html>"

    Write-Verbose "Sending alert with subject: $Subject"
    Write-Verbose "Sending alert with body:`n$body"

    # Send the alert
    SendAlertRaw -Subject $Subject -Message $body
}