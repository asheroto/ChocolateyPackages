$ErrorActionPreference = "Stop"

# Use PowerShell 7+ to run this script

# Initialize variables
$packageName = "ClickUp-Official"
$FILE_URL = 'https://desktop.clickup.com/windows'
$downloadPath = '.\ClickUp-Temp.exe'
$nuspecPath = '.\ClickUp-Official.nuspec'
$installScriptPath = '.\tools\ChocolateyInstall.ps1'

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
    # This function gets the URL from a secure string file and sends the alert by making a POST request to the URL

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
        Invoke-WebRequest -Uri $alertUrl -Method Post -Body $Message -ContentType "text/plain" | Out-Null
        Write-Output "Alert sent."
    }
}

function SendAlert {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Subject,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Create the HTML body for the notification
    $date = Get-Date -Format "yyyy-MM-dd hh:mm:ss tt"
    $body = "<html><body>"
    $body += "<font face='Arial'>"
    $body += "<p>$Message</p>"
    $body += "<p><strong>Time:</strong> $date</p>"
    $body += "</font>"
    $body += "</body></html>"

    # Send the alert
    SendAlertRaw -Subject $Subject -Message $body
}

try {

    # Download the file and get its ProductVersion
    # If aria2c is installed, use it to download the file because it's much faster
    # Otherwise, use Invoke-WebRequest
    if (Get-Command aria2c -ErrorAction SilentlyContinue) {
        aria2c --out=$downloadPath $FILE_URL
    } else {
        Invoke-WebRequest -Uri $FILE_URL -OutFile $downloadPath
    }
    $productVersion = (Get-Command $downloadPath).FileVersionInfo.ProductVersion

    # Trim the version to 3 parts if it has 4
    if ($productVersion -match '^\d+(\.\d+){3}$') {
        $productVersion = ($productVersion -split '\.')[0..2] -join '.'
    }

    # Get the current version from the nuspec
    $nuspecContent = Get-Content $nuspecPath -Raw
    $versionMatches = [regex]::Match($nuspecContent, '<version>(.*?)<\/version>')
    $nuspecVersion = $versionMatches.Groups[1].Value

    # Get the current checksum from the ps1 file
    $installScriptContent = Get-Content $installScriptPath -Raw
    $checksumMatches = [regex]::Match($installScriptContent, '\$checksum\s*=\s*"([^"]+)"')
    $currentChecksum = $checksumMatches.Groups[1].Value

    # Calculate the new checksum
    $newChecksum = (Get-FileHash -Algorithm SHA256 $downloadPath).Hash

    # Validate version strings
    if ($productVersion -match '^\d+(\.\d+){1,3}$' -and $nuspecVersion -match '^\d+(\.\d+){1,3}$') {
        # Compare versions and checksums
        if ([version]$productVersion -gt [version]$nuspecVersion -or $newChecksum -ne $currentChecksum) {
            # Update the nuspec version using regex
            $nuspecContent = $nuspecContent -replace '(<version>).*?(<\/version>)', "`${1}$productVersion`$2"
            Set-Content -Path $nuspecPath -Value $nuspecContent

            # Update the checksum in ChocolateyInstall.ps1
            $updatedInstallScriptContent = $installScriptContent -replace '(\$checksum\s*=\s*)".*"', "`$1`"$newChecksum`""
            Set-Content -Path $installScriptPath -Value $updatedInstallScriptContent

            # Write the new version to the console
            Write-Output "Updated to version $productVersion."

            # Send an alert
            SendAlert -Subject "$packageName Package Updated" -Message "$packageName has been updated to version $productVersion. It is now ready for testing."
        } else {
            Write-Output "No update needed."
        }
    } else {
        Write-Output "Invalid version format. Skipping update."

        # Send an alert
        SendAlert -Subject "$packageName Package Error" -Message "$packageName detected an invalid version format. Please check the update script and files."
    }
} catch {
    # Send an alert
    SendAlert -Subject "$packageName Package Error" -Message "$packageName had an error when checking for updates. Please check the update script and files.<br><br><strong>Error:</strong> $_"

    Write-Output "An error occurred: $_"
} finally {
    # Clean up the downloaded file
    Remove-Item -Path $downloadPath -ErrorAction SilentlyContinue
}