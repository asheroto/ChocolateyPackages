[CmdletBinding()]
param ()

# Function to get the latest version and download URL of Adobe Acrobat Reader DC
function Get-AdobeAcrobatReaderDCUrls {
    [CmdletBinding()]
    param ()

    # URL of the Adobe Acrobat Reader DC release notes page
    $apiUrl = 'https://helpx.adobe.com/acrobat/release-note/release-notes-acrobat-reader.html'
    Write-Debug "Fetching main release notes page: $apiUrl"

    try {
        # Fetch the main release notes page using curl.exe
        $response = curl.exe -s $apiUrl
        if ($response) {
            $htmlContent = $response
            Write-Debug "Main release notes page content fetched."
        } else {
            throw "Failed to fetch main release notes page."
        }
    } catch {
        # Handle errors in fetching the main release notes page
        Write-Debug "Error fetching main release notes page: $_"
        Write-Output "Error fetching main release notes page: $_"
        exit
    }

    # Extract the first <a> link that matches the specified pattern
    $linkPattern = [regex]::new('<a href="(https://www\.adobe\.com/devnet-docs/acrobatetk/tools/ReleaseNotesDC/[^"]+)"[^>]*>(DC [^<]+)</a>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $linkMatch = $linkPattern.Match($htmlContent)
    Write-Debug "Searching for the first release notes link..."

    if ($linkMatch.Success) {
        # Extract the release notes URL and version from the matched link
        $releaseNotesUrl = $linkMatch.Groups[1].Value
        $version = $linkMatch.Groups[2].Value
        Write-Debug "Release Notes URL: $releaseNotesUrl"
        Write-Debug "Version: $version"

        # Fetch the release notes page to get the .msp file link
        Write-Debug "Fetching release notes page: $releaseNotesUrl"
        try {
            $releaseNotesResponse = curl.exe -s $releaseNotesUrl
            if ($releaseNotesResponse) {
                $releaseNotesContent = $releaseNotesResponse
                Write-Debug "Release notes page content fetched."
            } else {
                throw "Failed to fetch release notes page."
            }
        } catch {
            # Handle errors in fetching the release notes page
            Write-Debug "Error fetching release notes page: $_"
            Write-Output "Error fetching release notes page: $_"
            exit
        }

        # Find the .msp file link in the release notes page
        $mspLinkPattern = [regex]::new('<a[^>]+href="([^"]+\.msp)"[^>]*>([^<]+)</a>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        $mspLinkMatch = $mspLinkPattern.Match($releaseNotesContent)
        Write-Debug "Searching for the .msp file link..."

        if ($mspLinkMatch.Success) {
            # Extract the .msp file URL and version
            $mspUrl = $mspLinkMatch.Groups[1].Value
            Write-Debug "MSP URL: $mspUrl"
            $mspFileName = [System.IO.Path]::GetFileNameWithoutExtension($mspUrl)
            $mspVersion = $mspFileName -replace '.*?(\d{4,}).*', '$1'
            Write-Debug "Extracted MSP Version: $mspVersion"

            # Construct the download URLs for the MUI installer and MSP update files
            $MUIurl = "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/$mspVersion/AcroRdrDC${mspVersion}_MUI.exe"
            Write-Debug "MUI URL: $MUIurl"

            $MUIurl64 = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/$mspVersion/AcroRdrDCx64${mspVersion}_MUI.exe"
            Write-Debug "MUI URL 64-bit: $MUIurl64"

            $MUImspURL = "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/$mspVersion/AcroRdrDCUpd${mspVersion}_MUI.msp"
            Write-Debug "MUI MSP URL: $MUImspURL"

            $MUImspURL64 = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/$mspVersion/AcroRdrDCx64Upd${mspVersion}_MUI.msp"
            Write-Debug "MUI MSP URL 64-bit: $MUImspURL64"

            # Return the extracted information as a PowerShell custom object
            return [PSCustomObject]@{
                Version         = $version
                ReleaseNotesUrl = $releaseNotesUrl
                MUIurl          = $MUIurl
                MUIurl64        = $MUIurl64
                MUImspURL       = $MUImspURL
                MUImspURL64     = $MUImspURL64
            }
        } else {
            # Handle cases where the .msp file link is not found
            Write-Debug "MSP file link not found."
            Write-Output "MSP file link not found."
            exit
        }
    } else {
        # Handle cases where the version link is not found
        Write-Debug "Version link not found."
        Write-Output "Version link not found."
        exit
    }
}

# Example usage
$latest = Get-AdobeAcrobatReaderDCUrls

# Write the latest version and URLs
$latest