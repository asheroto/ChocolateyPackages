[CmdletBinding()] # Enables -Debug parameter for troubleshooting
param ()

# Define the API URL
$apiUrl = 'https://www.ccleaner.com/en-us/api/knowledge/search?guid=f89265d7-1f47-4f3c-beb1-fc64b5a866fa&w=recuva'

# Function to get the latest version and download URL
function Get-LatestVersionAndUrl {
    $response = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing
    $jsonContent = $response.Content | ConvertFrom-Json

    # Extract the full version number from the URL
    $versionPattern = [regex]::new('recuva-v(\d+-\d+-\d+)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $versionMatch = $versionPattern.Match($jsonContent.url)

    # Extract the shortened version number from the title
    $titlePattern = [regex]::new('Recuva v(\d+\.\d+)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $titleMatch = $titlePattern.Match($jsonContent.title)

    if ($versionMatch.Success -and $titleMatch.Success) {
        $versionNumberFull = $versionMatch.Groups[1].Value -replace '-', '.'
        $versionNumberShort = $titleMatch.Groups[1].Value
        Write-Output "Version Number (Full): $versionNumberFull"
        Write-Output "Version Number (Short): $versionNumberShort"

        # Define the URL to download the installer using the shortened version number
        $fileUrl = "https://download.ccleaner.com/rcsetup$($versionNumberShort.Replace('.', '')).exe"
        Write-Debug "Download URL: $fileUrl"

        return @{
            URL32   = $fileUrl
            Version = $versionNumberFull
        }
    } else {
        Write-Output "Version number not found."
        exit
    }
}

# Function to calculate the checksum of a file
function Get-RemoteChecksum {
    param (
        [string]$Url,
        [string]$Algorithm = 'SHA256'
    )

    $webClient = New-Object System.Net.WebClient
    $tempFile = [System.IO.Path]::GetTempFileName()
    $webClient.DownloadFile($Url, $tempFile)

    $hashAlgorithm = [System.Security.Cryptography.HashAlgorithm]::Create($Algorithm)
    $fileStream = [System.IO.File]::OpenRead($tempFile)
    $checksumBytes = $hashAlgorithm.ComputeHash($fileStream)
    $fileStream.Close()

    $checksum = [BitConverter]::ToString($checksumBytes) -replace '-', ''
    Remove-Item -Path $tempFile

    return $checksum
}

# Get the latest version and URL
$Latest = Get-LatestVersionAndUrl

# Calculate the checksum
$checksum = Get-RemoteChecksum -Url $Latest.URL32

# Paths to the files
$nuspecFilePath = Resolve-Path "recuva.nuspec"
$installScriptPath = Resolve-Path ".\tools\chocolateyInstall.ps1"

# Read the .nuspec file content
$nuspecContent = Get-Content $nuspecFilePath -Raw

# Update version in nuspec file using regex replacement
$nuspecContent = [regex]::Replace($nuspecContent, '(<version>)(.*?)(</version>)', "<version>$($Latest.Version)</version>")
Set-Content -Path $nuspecFilePath -Value $nuspecContent -Encoding utf8NoBOM
Write-Output "Updated version in nuspec file to $Latest.Version."

# Read the ChocolateyInstall.ps1 script content
$installScriptContent = Get-Content $installScriptPath -Raw

# Update the URL, checksum, and version in ChocolateyInstall.ps1 script using regex replacement
$installScriptContent = $installScriptContent `
    -replace "(?<=Url\s*=\s*')[^']*", "$($Latest.URL32)" `
    -replace "(?<=Checksum\s*=\s*')[^']*", "$checksum" `
    -replace "(?<=Version\s*=\s*')[^']*", "$($Latest.Version)"

Set-Content -Path $installScriptPath -Value $installScriptContent -Encoding utf8NoBOM
Write-Output "Updated URL, checksum, and version in ChocolateyInstall.ps1 script."

# Optional: Run 'choco pack' to create the nupkg file
Write-Output "Creating nupkg file..."
choco pack

# Optional: Push the package to Chocolatey
if ($AutoPush) {
    $filename = "recuva.$($Latest.Version).nupkg"
    Write-Output "Pushing $filename to Chocolatey..."
    choco push $filename
}

# Import the Chocolatey package updater functions
. (Join-Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Definition)) 'functions.ps1')

# Send Alert
SendAlert -Subject "Recuva Updated" -Message "Recuva has been updated to version $($Latest.Version) but has NOT been automatically pushed to confirm it's still working right."