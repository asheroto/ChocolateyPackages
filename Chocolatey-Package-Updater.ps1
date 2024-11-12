<#PSScriptInfo

.VERSION 0.1.1

.GUID 9b612c16-25c0-4a40-afc7-f876274e7e8c

.AUTHOR asheroto

.COMPANYNAME asheroto

.TAGS PowerShell Windows Chocolatey choco package updater update maintain maintainer monitor monitoring alert notification exe installer automatic auto automated automation schedule scheduled scheduler task

.PROJECTURI https://github.com/asheroto/Chocolatey-Package-Updater

.RELEASENOTES
[Version 0.0.1] - Initial release, deployment and additional features still under development.
[Version 0.0.2] - Fixed wrong checksum variable being used
[Version 0.0.3] - Added support for stripping out the version number from the Product Version, as well as checking the File Version if the Product Version is not available. Improved pattern matching. Remove extra debug statements. Added logic to check if VERIFICATION.txt checksum changed. Add -Version and -CheckForUpdate parameters and logic. Added supported for ScrapeUrl, ScrapePattern, and VERSION replacement in URL.
[Version 0.0.4] - Major improvements. Added support for FileUrl64, checksum64.
[Version 0.0.5] - Abstracted version/checksum comparison into its own function.
[Version 0.0.6] - Added support for GitHubRepoUrl so that the latest version can be scraped from GitHub's API. Added GitHub repo example.
[Version 0.0.7] - Added additional wait time for cleanup to ensure files are release from use before deletion.
[Version 0.0.8] - Improved help. Added Help parameter. Added loop to repeatedly attempt file deletion if it's in use, mitigating file deletion prevention by antivirus software scanning download.
[Version 0.0.9] - Improved ProductVersion/FileVersion detection, only returns applicable Chocolatey version number despite the version provided in the metadata of the file/installer.
[Version 0.0.10] - Added disable IPv6 to aria2c args.
[Version 0.0.11] - Added ignore version.
[Version 0.0.12] - Added AutoPush for automatic pushing to Chocolatey community repository.
[Version 0.1.0] - Added Mailjet support for alerting.
[Version 0.1.1] - Fix bug with FileDestinationPath occurring after choco pack.

#>

<#

.SYNOPSIS
Streamline the management of Chocolatey packages by automating version updates, checksum validations, and alert notifications.

.DESCRIPTION
See project site for instructions on how to use including full parameter list and examples.

The script simplifies the process of updating Chocolatey packages by providing automated functionality to:
- No functions or regex expressions to write: everything happens automatically!
- Updates the version in the nuspec file.
- Updates the url/checksum and url64/checksum64 (if specified) in the ChocolateyInstall.ps1 script.
- Updates the checksum and checksum64 (if specified) in the VERIFICATION.txt file (if it exists).
- Updates the version number in the download URL (if specified).
- Sends an alert to a designated URL.
- Supports EXE files distributed in the package.
- Supports variable and hash table formats for checksum in the ChocolateyInstall.ps1 script.
- Supports single and double quotes for checksum in the ChocolateyInstall.ps1 script.
- Automatic support for aria2 download manager as well as Invoke-WebRequest.
- Supports scraping the version number from the download URL.
- Supports version number replacement in the download URL.
- Supports getting the latest version from a GitHub repository.

.EXAMPLE
# Required at top of each script
# Set vars to the script and the parent path ($ScriptPath MUST be defined for the UpdateChocolateyPackage function to work)
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ParentPath = Split-Path -Parent $ScriptPath

# Import the UpdateChocolateyPackage function
. (Join-Path $ParentPath 'Chocolatey-Package-Updater.ps1')

.EXAMPLE
# Create a hash table to store package information
$packageInfo = @{
    PackageName         = "fxsound"
    FileUrl             = 'https://download.fxsound.com/fxsoundlatest'   # URL to download the file from
    FileDestinationPath = '.\tools\fxsound_setup.exe'                    # Path to move/rename the temporary file to (if EXE is distributed in package
    EnvFilePath         = '..\.env'                                      # Path to the .env file containing environment variables
}

# Call the UpdateChocolateyPackage function and pass the hash table
UpdateChocolateyPackage @packageInfo

.EXAMPLE
To update a Chocolatey package, run the following command:
UpdateChocolateyPackage -PackageName "fxsound" -FileUrl "https://download.fxsound.com/fxsoundlatest" -Alert $true -EnvFilePath "..\.env"

.EXAMPLE
To update a Chocolatey package with additional parameters, run the following command:
UpdateChocolateyPackage -PackageName "fxsound" -FileUrl "https://download.fxsound.com/fxsoundlatest" -FileDownloadTempPath ".\fxsound_setup_temp.exe" -FileDestinationPath ".\tools\fxsound_setup.exe" -NuspecPath ".\fxsound.nuspec" -InstallScriptPath ".\tools\ChocolateyInstall.ps1" -VerificationPath ".\tools\VERIFICATION.txt" -Alert $true -EnvFilePath "..\.env"

.NOTES
- Version: 0.1.1
- Created by: asheroto
- See project site for instructions on how to use including full parameter list and examples.

.LINK
Project Site: https://github.com/asheroto/Chocolatey-Package-Updater

#>
[CmdletBinding()]
param (
    [switch]$CheckForUpdate,
    [switch]$Version,
    [switch]$Help
)

# ============================================================================ #
# Initial vars
# ============================================================================ #

$CurrentVersion = '0.1.1'
$RepoOwner = 'asheroto'
$RepoName = 'Chocolatey-Package-Updater'
$SoftwareName = 'Chocolatey Package Updater'
$PowerShellGalleryName = 'Chocolatey-Package-Updater'

# Suppress progress bar (makes downloading super fast)
$ProgressPreference = 'SilentlyContinue'

# Display version if -Version is specified
if ($Version.IsPresent) {
    $CurrentVersion
    exit 0
}

# Display full help if -Help is specified
if ($Help) {
    Get-Help -Name $MyInvocation.MyCommand.Source -Full
    exit 0
}

function Get-GitHubRelease {
    <#
        .SYNOPSIS
        Fetches the latest release information of a GitHub repository.

        .DESCRIPTION
        This function uses the GitHub API to get information about the latest release of a specified repository, including its version and the date it was published.

        .PARAMETER Owner
        The GitHub username of the repository owner.

        .PARAMETER Repo
        The name of the repository.

        .EXAMPLE
        Get-GitHubRelease -Owner "asheroto" -Repo "winget-install"
        This command retrieves the latest release version and published datetime of the winget-install repository owned by asheroto.
    #>
    [CmdletBinding()]
    param (
        [string]$Owner,
        [string]$Repo
    )
    try {
        $url = "https://api.github.com/repos/$Owner/$Repo/releases/latest"
        $response = Invoke-RestMethod -Uri $url -ErrorAction Stop

        $latestVersion = $response.tag_name
        $publishedAt = $response.published_at

        # Convert UTC time string to local time
        $UtcDateTime = [DateTime]::Parse($publishedAt, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::RoundtripKind)
        $PublishedLocalDateTime = $UtcDateTime.ToLocalTime()

        [PSCustomObject]@{
            LatestVersion     = $latestVersion
            PublishedDateTime = $PublishedLocalDateTime
        }
    } catch {
        Write-Error "Unable to check for updates.`nError: $_"
        exit 1
    }
}

function CheckForUpdate {
    param (
        [string]$RepoOwner,
        [string]$RepoName,
        [version]$CurrentVersion,
        [string]$PowerShellGalleryName
    )

    $Data = Get-GitHubRelease -Owner $RepoOwner -Repo $RepoName

    if ($Data.LatestVersion -gt $CurrentVersion) {
        Write-Output "`nA new version of $RepoName is available.`n"
        Write-Output "Current version: $CurrentVersion."
        Write-Output "Latest version: $($Data.LatestVersion)."
        Write-Output "Published at: $($Data.PublishedDateTime).`n"
        Write-Output "You can download the latest version from https://github.com/$RepoOwner/$RepoName/releases`n"
        if ($PowerShellGalleryName) {
            Write-Output "Or you can run the following command to update:"
            Write-Output "Install-Script $PowerShellGalleryName -Force`n"
        }
    } else {
        Write-Output "`n$RepoName is up to date.`n"
        Write-Output "Current version: $CurrentVersion."
        Write-Output "Latest version: $($Data.LatestVersion)."
        Write-Output "Published at: $($Data.PublishedDateTime)."
        Write-Output "`nRepository: https://github.com/$RepoOwner/$RepoName/releases`n"
    }
    exit 0
}

# ============================================================================ #
# Initial checks
# ============================================================================ #

# Check for updates if -CheckForUpdate is specified
if ($CheckForUpdate) {
    CheckForUpdate -RepoOwner $RepoOwner -RepoName $RepoName -CurrentVersion $CurrentVersion -PowerShellGalleryName $PowerShellGalleryName
}

# Heading
Write-Output "$SoftwareName $CurrentVersion"
Write-Output "To check for updates, run $RepoName -CheckForUpdate"

function UpdateFileContent {
    [OutputType([System.String])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [Parameter(Mandatory = $true)]
        [string]$Pattern,
        [Parameter(Mandatory = $true)]
        [string]$Replacement
    )
    $absolutePath = (Resolve-Path $FilePath).ProviderPath
    Write-Debug "Working with file: $absolutePath"

    if (Test-Path $absolutePath) {
        $fileContent = Get-Content $absolutePath -Raw

        if ($fileContent -match $Pattern) {
            Write-Debug "Pattern found in file"
            $matchedText = $matches[0]  # Capture the matched text

            if ($matchedText -eq $Replacement) {
                Write-Debug "Replacement text is the same as the existing text. No changes needed."
                return "No changes needed"
            } else {
                $updatedContent = $fileContent -replace $Pattern, $Replacement
                [System.IO.File]::WriteAllText($absolutePath, $updatedContent)
                $verifyContent = Get-Content $absolutePath -Raw

                # Escape special characters in the replacement string for regex matching
                $escapedReplacement = [regex]::Escape($Replacement)
                if ($verifyContent -match $escapedReplacement) {
                    Write-Debug "Replacement verified in file"
                    return "true"
                } else {
                    return "Replacement not found in file"
                }
            }
        } else {
            return "Pattern not found in file"
        }
    } else {
        return "File not found"
    }
}

function HandleUpdateResult {
    param (
        [string]$Result,
        [string]$SuccessMessage,
        [string]$FailureMessage
    )

    if ($Result -eq "true") {
        Write-Output $SuccessMessage
    } elseif ($Result -eq "No changes needed") {
        Write-Output "No changes were needed."
    } else {
        Write-Output $FailureMessage
    }
}

function SendEmailMailjet {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Subject,

        [Parameter(Mandatory = $true)]
        [string]$TextContent,

        [Parameter(Mandatory = $false)]
        [string]$HtmlContent,

        [Parameter(Mandatory = $false)]
        [string]$EnvFilePath
    )

    # Load environment variables from the specified file if specified
    if ($EnvFilePath) {
        Load-DotEnv -Path $EnvFilePath
    }

    $ApiKey = $env:MAILJET_API_KEY
    $ApiSecret = $env:MAILJET_API_SECRET
    $FromEmail = $env:MAILJET_FROM_EMAIL
    $FromName = $env:MAILJET_FROM_NAME
    $ToEmail = $env:MAILJET_TO_EMAIL
    $ToName = $env:MAILJET_TO_NAME

    if (-not $ApiKey -or -not $ApiSecret -or -not $FromEmail -or -not $FromName -or -not $ToEmail -or -not $ToName) {
        Write-Warning "One or more required environment variables are missing."
        return
    }

    $url = "https://api.mailjet.com/v3.1/send"

    $body = @{
        Messages    = @(
            @{
                From     = @{
                    Email = $FromEmail
                    Name  = $FromName
                }
                To       = @(
                    @{
                        Email = $ToEmail
                        Name  = $ToName
                    }
                )
                Subject  = $Subject
                TextPart = $TextContent
                HTMLPart = $HtmlContent
            }
        )
        SandboxMode = $false
    } | ConvertTo-Json -Depth 10

    $headers = @{
        "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${ApiKey}:${ApiSecret}")))"
        "Content-Type"  = "application/json"
    }

    try {
        $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
        Write-Output "Email sent successfully."
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug']) {
            Write-Debug "Response: $($response | ConvertTo-Json -Depth 3)"
        }
    } catch {
        Write-Warning "Failed to send email."
        Write-Warning "Error details: $_"
        if ($PSCmdlet.MyInvocation.BoundParameters['Debug']) {
            Write-Debug $_.Exception.Message
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
        [boolean]$Alert = $true,

        [Parameter(Mandatory = $false)]
        [string]$EnvFilePath
    )

    if (!$Alert) {
        Write-Output "Alert disabled. Skipping alert."
        return
    }

    Write-Output "Sending alert..."

    $date = Get-Date -Format "yyyy-MM-dd hh:mm:ss tt"
    $body = "$Message`n`nTime: $date"

    Write-Verbose "Sending alert with subject: $Subject"
    Write-Verbose "Sending alert with body:`n$body"

    SendEmailMailjet -Subject $Subject -TextContent $body -EnvFilePath $EnvFilePath
}

function Load-DotEnv {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $false)]
        [ValidateSet("Process", "User", "Machine")]
        [string]$Scope = "Process"  # Default scope is Process
    )

    # Determine if the given path is a file or a directory
    if (Test-Path -Path $Path -PathType Container) {
        $envFilePath = Join-Path -Path $Path -ChildPath ".env"
    } elseif (Test-Path -Path $Path -PathType Leaf) {
        $envFilePath = $Path
    } else {
        Write-Warning "The specified path does not exist: $Path"
        return
    }

    if (-not (Test-Path -Path $envFilePath)) {
        Write-Warning "The .env file does not exist at the specified location: $envFilePath"
        return
    }

    Get-Content $envFilePath | ForEach-Object {
        $_.Trim() | ForEach-Object {
            if ($_ -match '^\s*#' -or $_ -eq '') {
                # Skip comments and empty lines
                return
            }
            if ($_ -match '^\s*([^=]+?)\s*=\s*(.*?)\s*$') {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim()

                # Remove surrounding quotes if they exist
                if ($value.StartsWith('"') -and $value.EndsWith('"')) {
                    $value = $value.Substring(1, $value.Length - 2)
                } elseif ($value.StartsWith("'") -and $value.EndsWith("'")) {
                    $value = $value.Substring(1, $value.Length - 2)
                }

                # Set the environment variable with the specified scope
                [System.Environment]::SetEnvironmentVariable($key, $value, $Scope)
            }
        }
    }

    Write-Debug "Environment variables loaded from $envFilePath with scope $Scope"
}

function Write-Section {
    <#
        .SYNOPSIS
        Prints a text block surrounded by a section divider for enhanced output readability.

        .DESCRIPTION
        This function takes a message input and prints it to the console, surrounded by a section divider made of hash characters.
        It enhances the readability of console output by categorizing messages based on the Type parameter.

        .PARAMETER Message
        The message to be printed within the section divider. This parameter is mandatory.

        .PARAMETER Type
        The type of message to display. Possible values: "Output" (default), "Debug," "Warning," "Information," "Verbose."

        .EXAMPLE
        Write-Section -Message "This is a sample message."

        This command prints the provided message surrounded by a section divider. Because the Type parameter is not specified, it defaults to "Output."

        .EXAMPLE
        Write-Section "This is another sample message."

        This command also prints the message surrounded by a section divider. The -Message parameter is implied and does not need to be explicitly named.

        .EXAMPLE
        Write-Section -Message "This is a warning message." -Type "Warning"

        This command prints the provided message surrounded by a section divider and uses Write-Warning to display the message, due to the Type parameter being set to "Warning."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,
        [ValidateSet("Output", "Debug", "Warning", "Information", "Verbose")]
        [string]$Type = "Output"
    )

    $consoleWidth = [System.Console]::WindowWidth - 2
    $prependLength = 0

    switch ($Type) {
        "Output" { $writeCmd = { Write-Output $args[0] } }
        "Debug" { $writeCmd = { Write-Debug $args[0] }; $prependLength = 7 }
        "Warning" { $writeCmd = { Write-Warning $args[0] }; $prependLength = 9 }
        "Information" { $writeCmd = { Write-Information $args[0] }; }
        "Verbose" { $writeCmd = { Write-Verbose $args[0] }; $prependLength = 9 }
    }

    $divider = "#" * ($consoleWidth - $prependLength)
    & $writeCmd $divider

    $words = $Message -split ' '
    $line = "# "
    foreach ($word in $words) {
        if (($line.Length + $word.Length + 1) -gt ($consoleWidth - $prependLength - 1)) {
            $line = $line.PadRight($consoleWidth - $prependLength - 1) + "#"
            & $writeCmd $line
            $line = "# "
        }
        $line += "$word "
    }

    if ($line.Trim().Length -gt 1) {
        $line = $line.PadRight($consoleWidth - $prependLength - 1) + "#"
        & $writeCmd $line
    }

    $divider = "#" * ($consoleWidth - $prependLength)
    & $writeCmd $divider
}

function Get-LatestGitHubReleaseVersion {
    param (
        [Parameter(Mandatory = $true)]
        [string]$GitHubRepoUrl
    )

    # Extract the username and repo name from the provided URL
    $repoDetails = $GitHubRepoUrl -replace '^https://github.com/', '' -split '/'

    $username = $repoDetails[0]
    $repoName = $repoDetails[1]

    $apiUrl = "https://api.github.com/repos/$username/$repoName/releases/latest"

    $response = Invoke-RestMethod -Uri $apiUrl
    $latestVersionTag = $response.tag_name

    # Use regex to extract version number
    if ($latestVersionTag -match '(\d+\.\d+\.\d+)') {
        return $matches[1]
    } else {
        throw "Failed to extract version from tag: $latestVersionTag"
    }
}

function UpdateChocolateyPackage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,

        [Parameter(Mandatory = $true)]
        [string]$FileUrl,

        [Parameter(Mandatory = $false)]
        [string]$FileUrl64,

        [Parameter(Mandatory = $false)]
        [string]$FileDownloadTempPath,

        [Parameter(Mandatory = $false)]
        [string]$FileDownloadTempPath64,

        [Parameter(Mandatory = $false)]
        [string]$FileDestinationPath,

        [Parameter(Mandatory = $false)]
        [string]$FileDestinationPath64,

        [Parameter(Mandatory = $false)]
        [string]$NuspecPath = ".\$PackageName.nuspec",

        [Parameter(Mandatory = $false)]
        [string]$InstallScriptPath = '.\tools\ChocolateyInstall.ps1',

        [Parameter(Mandatory = $false)]
        [string]$VerificationPath = '.\tools\VERIFICATION.txt',

        [Parameter(Mandatory = $false)]
        [boolean]$Alert = $true,

        [Parameter(Mandatory = $false)]
        [string]$AlertEmailAddress,

        [Parameter(Mandatory = $false)]
        [string]$ScrapeUrl,

        [Parameter(Mandatory = $false)]
        [string]$ScrapePattern,

        [Parameter(Mandatory = $false)]
        [string]$DownloadUrlScrapePattern,

        [Parameter(Mandatory = $false)]
        [string]$DownloadUrlScrapePattern64,

        [Parameter(Mandatory = $false)]
        [string]$GitHubRepoUrl,

        [Parameter(Mandatory = $false)]
        [string]$IgnoreVersion,

        [Parameter(Mandatory = $false)]
        [boolean]$AutoPush,

        [Parameter(Mandatory = $false)]
        [string]$EnvFilePath
    )

    function Try-DeleteFile {
        # Try to delete the file and return true if successful, false if not
        param (
            [string]$filePath
        )
        try {
            Remove-Item -Path $filePath -Force -ErrorAction Stop
            return $true
        } catch {
            return $false
        }
    }

    function WaitForReleaseAndDelete {
        # Wait for the file to be released by the process and delete it
        param (
            [string]$filePath,
            [int]$maxTimeout
        )
        $fileName = [System.IO.Path]::GetFileName($filePath)
        $elapsedTime = 0
        while ($elapsedTime -lt $maxTimeout) {
            if (Try-DeleteFile -filePath $filePath) {
                Write-Output "$fileName deleted"
                return
            }
            Start-Sleep -Seconds 1
            $elapsedTime++
        }
        Write-Output "Timeout reached, $fileName not deleted"
    }

    function CleanupFileDownload {
        # Check if FileDownloadTempDelete is not set
        # Check if the file exists at the specified path
        if (Test-Path $FileDownloadTempPath) {
            # Remove the file
            Write-Debug "Removing temporary file: $FileDownloadTempPath"
            WaitForReleaseAndDelete -filePath $FileDownloadTempPath -maxTimeout 10
        }

        # If FileUrl64 is used, check if the file exists at the specified path
        if ($FileUrl64 -and (Test-Path $FileDownloadTempPath64)) {
            Write-Debug "Removing temporary file: $FileDownloadTempPath64"
            WaitForReleaseAndDelete -filePath $FileDownloadTempPath64 -maxTimeout 10
        }
    }

    # Internal function to handle file download
    function DownloadFile {
        param(
            [string]$Url,
            [string]$TempPath,
            [boolean]$Is64Bit = $false
        )

        if ($Is64Bit -eq $false) {
            Write-Output "Downloading file: $url"
        } else {
            Write-Output "Downloading file (64-bit): $url"
        }

        Write-Debug "Saving to: $tempPath"

        # Check if aria2c exists and use it for downloading if possible
        if (Get-Command aria2c -ErrorAction SilentlyContinue) {
            Write-Debug "aria2c is detected and will be used to download the file."

            # Extract the directory part and the file part from the absolute path (aria2c treats paths as relative)
            $directoryPart = [System.IO.Path]::GetDirectoryName($tempPath)
            $filePart = [System.IO.Path]::GetFileName($tempPath)

            # Construct the aria2c command line arguments
            # Using spoofed user agent because some sites block aria2c
            $aria2cArgs = @("-d", $directoryPart, "-o", $filePart, $url, "--disable-ipv6")

            if ($DebugPreference -eq 'SilentlyContinue') {
                $aria2cArgs += '--quiet'
            }

            # Run aria2c
            & 'aria2c' $aria2cArgs
        } else {
            Write-Debug "Using Invoke-WebRequest to download the file."
            Invoke-WebRequest -Uri $url -OutFile $tempPath
        }

        # Verify the file exists
        if (Test-Path $tempPath) {
            Write-Debug "File exists: $tempPath"
        } else {
            throw "File not found: $tempPath"
        }
    }

    function Get-ProductVersion {
        param(
            [string]$FileDownloadTempPath,
            [string]$ForceVersionNumber
        )

        $ProductVersion = $null
        $versionPattern = '(\d+\.\d+)(\.\d+)?(\.\d+)?'

        if ($ForceVersionNumber) {
            $ProductVersion = $ForceVersionNumber
        } else {
            $fileInfo = (Get-Command $FileDownloadTempPath).FileVersionInfo

            if ($fileInfo.ProductVersion) {
                $matches = [regex]::Match($fileInfo.ProductVersion, $versionPattern)
                if ($matches.Success) {
                    $majorMinor = $matches.Groups[1].Value
                    $patch = $matches.Groups[2].Success ? $matches.Groups[2].Value : ".0"
                    $ProductVersion = $majorMinor + $patch
                }
            }

            if ($null -eq $ProductVersion -and $fileInfo.FileVersion) {
                $matches = [regex]::Match($fileInfo.FileVersion, $versionPattern)
                if ($matches.Success) {
                    $majorMinor = $matches.Groups[1].Value
                    $patch = $matches.Groups[2].Success ? $matches.Groups[2].Value : ".0"
                    $ProductVersion = $majorMinor + $patch
                }
            }
        }

        return $ProductVersion
    }

    function PerformComparison {
        param (
            [string]$ProductVersion,
            [string]$NuspecVersion,
            [string]$ChocolateyInstallChecksum,
            [string]$NewChecksum,
            [string]$ChocolateyInstallChecksum64,
            [string]$NewChecksum64,
            [string]$VerificationPath,
            [string]$VerificationChecksum,
            [string]$VerificationChecksum64,
            [string]$FileUrl64,
            [string]$IgnoreVersion
        )

        $result = @{}
        $result["ProductVersion"] = $ProductVersion -eq $NuspecVersion
        $result["ChocolateyInstallChecksum"] = $ChocolateyInstallChecksum -eq $NewChecksum

        if ($FileUrl64) {
            $result["ChocolateyInstallChecksum64"] = $ChocolateyInstallChecksum64 -eq $NewChecksum64
        }

        if (Test-Path $VerificationPath) {
            $result["VerificationChecksum"] = $VerificationChecksum -eq $NewChecksum

            if ($FileUrl64) {
                $result["VerificationChecksum64"] = $VerificationChecksum64 -eq $NewChecksum64
            }
        }

        $result["OverallComparison"] = $result.Values -contains $false

        Write-Debug "Comparison results: $($result | Out-String)"
        return $result
    }

    function Remove-LeadingZeroesFromVersion {
        param (
            [string]$VersionNumber
        )

        $versionParts = $VersionNumber -split '\.'
        $cleanedVersionParts = $versionParts | ForEach-Object { [int]$_ }
        $cleanedVersion = ($cleanedVersionParts -join '.')

        return $cleanedVersion
    }

    # ============================================================================ #
    #  Main Script
    # ============================================================================ #

    try {
        # Heading
        Write-Section "Updating package: $PackageName"

        # Initialization and Path Management
        Push-Location
        Set-Location $ScriptPath
        Write-Debug "Current directory: $pwd"

        # Temporary File Cleanup
        CleanupFileDownload

        # FileDownloadTempPath Management
        if (-not $FileDownloadTempPath) {
            $FileDownloadTempPath = Join-Path -Path $env:TEMP -ChildPath "${PackageName}_setup_temp.exe"
        }

        if ($FileUrl64 -and -not $FileDownloadTempPath64) {
            $FileDownloadTempPath64 = Join-Path -Path $env:TEMP -ChildPath "${PackageName}_setup_temp_64.exe"
        }

        # Scrape Version if Applicable
        $ForceVersionNumber = ''
        if ($ScrapeUrl -and $ScrapePattern) {
            Write-Debug "Scraping URL: $ScrapeUrl"
            Write-Debug "Scrape pattern: $ScrapePattern"

            $page = Invoke-WebRequest -Uri $ScrapeUrl
            if ($page.Content -match $ScrapePattern -and $matches[0] -match '^\d+(\.\d+){1,3}$') {
                Write-Output "Scraped version: $($matches[0])"
                $ForceVersionNumber = $matches[0]
            } else {
                throw "No match found or invalid version."
            }
        }

        # Scrape download URL if applicable
        if ($ScrapeUrl -and $DownloadUrlScrapePattern) {
            Write-Debug "Scraping URL: $ScrapeUrl"
            Write-Debug "Download URL scrape pattern: $DownloadUrlScrapePattern"

            $page = Invoke-WebRequest -Uri $ScrapeUrl
            if ($page.Content -match $DownloadUrlScrapePattern) {
                Write-Output "Scraped download URL: $($matches[0])"
                $FileUrl = $matches[0]
            } else {
                throw "No match found or invalid version."
            }

            # Scrape 64-bit download URL if applicable
            if ($DownloadUrlScrapePattern64) {
                Write-Debug "Scraping URL: $ScrapeUrl"
                Write-Debug "Download URL scrape pattern (64-bit): $DownloadUrlScrapePattern"

                $page = Invoke-WebRequest -Uri $ScrapeUrl
                if ($page.Content -match $DownloadUrlScrapePattern64) {
                    Write-Output "Scraped 64-bit download URL: $($matches[0])"
                    $FileUrl64 = $matches[0]
                } else {
                    throw "No match found or invalid version."
                }
            }
        }

        # If GitHubRepoUrl is specified, get the latest version from GitHub
        if ($GitHubRepoUrl) {
            Write-Debug "GitHub repo URL: $GitHubRepoUrl"
            $ForceVersionNumber = Get-LatestGitHubReleaseVersion -GitHubRepoUrl $GitHubRepoUrl
        }

        # URL Modification with Version Number
        if ($ForceVersionNumber -and $FileUrl) {
            $FileUrl = $FileUrl -replace '{VERSION}', $ForceVersionNumber
        }
        if ($ForceVersionNumber -and $FileUrl64) {
            $FileUrl64 = $FileUrl64 -replace '{VERSION}', $ForceVersionNumber
        }

        # File Download and Product Version
        DownloadFile -Url $FileUrl -TempPath $FileDownloadTempPath
        $ProductVersion = Get-ProductVersion -FileDownloadTempPath $FileDownloadTempPath -ForceVersionNumber $ForceVersionNumber
        Write-Debug "Product version: $ProductVersion"

        # 64-bit File Processing
        if ($FileUrl64) {
            DownloadFile -Url $FileUrl64 -TempPath $FileDownloadTempPath64 -Is64Bit $true
            $ProductVersion64 = Get-ProductVersion -FileDownloadTempPath $FileDownloadTempPath64 -ForceVersionNumber $ForceVersionNumber
        }

        # Remove leading zeroes from version numbers
        $ProductVersion = Remove-LeadingZeroesFromVersion -VersionNumber $ProductVersion
        if ($ProductVersion64) {
            $ProductVersion64 = Remove-LeadingZeroesFromVersion -VersionNumber $ProductVersion64
        }

        # Nuspec Version and Checksums
        $NuspecContent = Get-Content $NuspecPath -Raw
        $NuspecVersion = ([regex]::Match($NuspecContent, '<version>(.*?)<\/version>')).Groups[1].Value

        $NewChecksum = (Get-FileHash -Algorithm SHA256 $FileDownloadTempPath).Hash
        $NewChecksum64 = if ($FileUrl64) { (Get-FileHash -Algorithm SHA256 $FileDownloadTempPath64).Hash } else { $null }

        # Define the match pattern for checksum in ChocolateyInstall.ps1
        $ChocolateyInstallPattern = '(?i)(?<=(checksum\s*=\s*)["''])(.*?)(?=["''])'
        $ChocolateyInstallPattern64 = '(?i)(?<=(checksum64\s*=\s*)["''])(.*?)(?=["''])'

        # Extract the current checksum from ChocolateyInstall.ps1
        $ChocolateyInstallContent = Get-Content $InstallScriptPath -Raw
        $ChocolateyInstallChecksumMatches = [regex]::Match($ChocolateyInstallContent, $ChocolateyInstallPattern)
        $ChocolateyInstallChecksum = $ChocolateyInstallChecksumMatches.Value.Trim("'")

        # Extract the current checksum from ChocolateyInstall.ps1 for 64-bit
        $ChocolateyInstallChecksumMatches64 = [regex]::Match($ChocolateyInstallContent, $ChocolateyInstallPattern64)
        $ChocolateyInstallChecksum64 = $ChocolateyInstallChecksumMatches64.Value.Trim("'")

        # Verification Patterns
        $VerificationPattern = '(?i)(?<=checksum:\s*)\w+'
        $VerificationPattern64 = '(?i)(?<=checksum64:\s*)\w+'

        # Extract the current checksum from VERIFICATION.txt if the file exists
        if (Test-Path $VerificationPath) {
            $VerificationContent = Get-Content $VerificationPath -Raw
            $VerificationChecksumMatches = [regex]::Match($VerificationContent, $VerificationPattern)
            $VerificationChecksum = $VerificationChecksumMatches.Value

            if ($FileUrl64) {
                $VerificationChecksumMatches64 = [regex]::Match($VerificationContent, $VerificationPattern64)
                $VerificationChecksum64 = $VerificationChecksumMatches64.Value
            }
        }

        Write-Output "Product version: $ProductVersion"

        if ($ProductVersion64) {
            Write-Output "Product version (64-bit): $ProductVersion64"
        }

        # Check if the 64-bit URL is specified and the product versions are different
        if ($FileUrl64 -and $ProductVersion -ne $ProductVersion64) {
            throw "Product versions are different. Please ensure that the 32-bit and 64-bit versions are the same."
        }

        Write-Output "Nuspec version: $NuspecVersion"

        # If the version is the same as the ignore version, skip the comparison
        if ($ProductVersion -eq $IgnoreVersion) {
            Write-Output "IgnoreVersion specified, ignoring comparison for version: $IgnoreVersion"
            return
        }

        Write-Output "New checksum: $NewChecksum"
        if ($FileUrl64) {
            Write-Output "New checksum (64-bit): $NewChecksum64"
        }

        Write-Output "ChocolateyInstall.ps1 checksum: $ChocolateyInstallChecksum"

        if ($FileUrl64) {
            Write-Output "ChocolateyInstall.ps1 checksum (64-bit): $ChocolateyInstallChecksum64"
        }

        # Output for default checksum
        if (Test-Path $VerificationPath) {
            Write-Output "Verification checksum: $VerificationChecksum"
            if ($FileUrl64) {
                Write-Output "Verification checksum (64-bit): $VerificationChecksum64"
            }
        }

        # Validate version strings
        if ($ProductVersion -match '^\d+(\.\d+){1,3}$' -and $NuspecVersion -match '^\d+(\.\d+){1,3}$') {
            Write-Debug "Version strings are valid."

            # Compare versions, compare ChocolateyInstall.ps1 checksum, and compare VERIFICATION.txt checksum if $VerificationPath is set and the file exists
            Write-Output "Comparing versions and checksums..."
            $comparisonResult = PerformComparison -ProductVersion $ProductVersion -NuspecVersion $NuspecVersion -ChocolateyInstallChecksum $ChocolateyInstallChecksum -NewChecksum $NewChecksum -ChocolateyInstallChecksum64 $ChocolateyInstallChecksum64 -NewChecksum64 $NewChecksum64 -VerificationPath $VerificationPath -VerificationChecksum $VerificationChecksum -VerificationChecksum64 $VerificationChecksum64 -FileUrl64 $FileUrl64
            if ($comparisonResult["OverallComparison"]) {
                Write-Output "Version or checksum is different. Updating package..."

                # Update version in nuspec file
                Write-Output "Updating version in nuspec file..."

                # Update the <version> tag
                $nuspecVersionResult = UpdateFileContent -FilePath $NuspecPath -Pattern '(?<=<version>).*?(?=<\/version>)' -Replacement $ProductVersion
                HandleUpdateResult -Result $nuspecVersionResult -SuccessMessage "Updated version in nuspec file" -FailureMessage "Failed to update version in nuspec file`n$nuspecVersionResult"

                # ChocolateyInstall.ps1
                # Update version
                Write-Output "Updating version in ChocolateyInstall.ps1 script (if it exists)..."
                $chocolateyInstallVersionPattern = '(?i)(?<=(version\s*=\s*)["''])(.*?)(?=["''])'
                $chocolateyInstallVersionResult = UpdateFileContent -FilePath $InstallScriptPath -Pattern $chocolateyInstallVersionPattern -Replacement $ProductVersion
                HandleUpdateResult -Result $chocolateyInstallVersionResult -SuccessMessage "Updated version in ChocolateyInstall.ps1 script" -FailureMessage "Did not update version in ChocolateyInstall.ps1 script, ignore error if not used`nMessage: $chocolateyInstallVersionResult"

                # ChocolateyInstall.ps1
                # Update url if ForceVersionNumber is not set, unless DownloadUrlScrapePattern or DownloadUrlScrapePattern64 is set
                if (-not $ForceVersionNumber -or $DownloadUrlScrapePattern -or $DownloadUrlScrapePattern64) {
                    Write-Output "Updating URL in ChocolateyInstall.ps1 script (if it exists)..."
                    $chocolateyInstallUrlPattern = '(?i)(?<=(url\s*=\s*)["''])(.*?)(?=["''])'
                    $chocolateyInstallUrlResult = UpdateFileContent -FilePath $InstallScriptPath -Pattern $chocolateyInstallUrlPattern -Replacement $FileUrl
                    HandleUpdateResult -Result $chocolateyInstallUrlResult -SuccessMessage "Updated URL in ChocolateyInstall.ps1 script" -FailureMessage "Did not update version in ChocolateyInstall.ps1 script, ignore error if not used`nMessage: $chocolateyInstallUrlResult"
                } else {
                    Write-Output "Version replacement is occurring in ChocolateyInstall.ps1 script. Skipping URL update in script."
                }

                # ChocolateyInstall.ps1
                # Update checksum
                Write-Output "Updating checksum in ChocolateyInstall.ps1 script..."
                $chocolateyInstallResult = UpdateFileContent -FilePath $InstallScriptPath -Pattern $ChocolateyInstallPattern -Replacement $NewChecksum
                HandleUpdateResult -Result $chocolateyInstallResult -SuccessMessage "Updated checksum in ChocolateyInstall.ps1 script" -FailureMessage "Did not update version in ChocolateyInstall.ps1 script, ignore if not used`nMessage: $chocolateyInstallResult"

                # ChocolateyInstall.ps1
                # Update url64 and checksum64
                if ($FileUrl64 -and $FileDownloadTempPath64) {
                    # Update the url64 or url64bit in ChocolateyInstall.ps1 if ForceVersionNumber is not set
                    if (-not $ForceVersionNumber) {
                        Write-Output "Updating url64 or url64bit in ChocolateyInstall.ps1 script (if it exists)..."
                        $chocolateyInstallUrl64Pattern = '(?i)(?<=(url64bit\s*=\s*)["''])(.*?)(?=["''])|(?i)(?<=(url64\s*=\s*)["''])(.*?)(?=["''])'
                        $chocolateyInstallUrl64Result = UpdateFileContent -FilePath $InstallScriptPath -Pattern $chocolateyInstallUrl64Pattern -Replacement $FileUrl64
                        HandleUpdateResult -Result $chocolateyInstallUrl64Result -SuccessMessage "Updated URL64 in ChocolateyInstall.ps1 script" -FailureMessage "Did not update URL64 in ChocolateyInstall.ps1 script, ignore error if not used`nMessage: $chocolateyInstallUrl64Result"
                    } else {
                        Write-Output "Version replacement is occurring in ChocolateyInstall.ps1 script. Skipping URL64 update in script."
                    }

                    # Update the checksum64 in ChocolateyInstall.ps1
                    Write-Output "Updating checksum64 in ChocolateyInstall.ps1 script (if it exists)..."
                    $chocolateyInstallResult64 = UpdateFileContent -FilePath $InstallScriptPath -Pattern $ChocolateyInstallPattern64 -Replacement $NewChecksum64
                    HandleUpdateResult -Result $chocolateyInstallResult64 -SuccessMessage "Updated checksum64 in ChocolateyInstall.ps1 script" -FailureMessage "Did not update checksum64 in ChocolateyInstall.ps1 script, ignore error if not used`Message: $chocolateyInstallResult64"
                }

                # VERIFICATION.txt
                # Check whether $VerificationPath and if set, check if it exists or not
                if (Test-Path $VerificationPath) {
                    # checksum
                    Write-Debug "Verification path is set and file exists. Updating checksum in verification file: $VerificationPath."
                    $verificationResult = UpdateFileContent -FilePath $VerificationPath -Pattern $VerificationPattern -Replacement $NewChecksum
                    HandleUpdateResult -Result $verificationResult -SuccessMessage "Updated checksum in verification file" -FailureMessage "Did not update checksum in verification file, ignore error if not used`nMessage: $verificationResult"

                    # checksum64
                    if ($FileUrl64) {
                        if (Test-Path $VerificationPath) {
                            Write-Debug "Verification path is set and file exists. Updating checksum64 in verification file: $VerificationPath."
                            $verificationResult64 = UpdateFileContent -FilePath $VerificationPath -Pattern $VerificationPattern64 -Replacement $NewChecksum64
                            HandleUpdateResult -Result $verificationResult64 -SuccessMessage "Updated checksum64 in verification file" -FailureMessage "Did not update checksum64 in verification file, ignore error if not used`nMessage: $verificationResult64"
                        }
                    }
                }

                # If the destination path is specified, move the downloaded file to the specified destination
                if ($FileDestinationPath) {
                    Write-Debug "Moving file `"${FileDownloadTempPath}`" to `"${FileDestinationPath}`""
                    try {
                        Move-Item $FileDownloadTempPath -Destination $FileDestinationPath -Force
                    } catch {
                        throw "Failed to move file `"${FileDownloadTempPath}`" to `"${FileDestinationPath}`" with error: $_"
                    }
                }

                # If the destination path is specified, move the downloaded file to the specified destination for 64-bit
                if ($FileUrl64 -and $FileDestinationPath64) {
                    Write-Debug "Moving file `"${FileDownloadTempPath64}`" to `"${FileDestinationPath64}`""
                    try {
                        Move-Item $FileDownloadTempPath64 -Destination $FileDestinationPath64 -Force
                    } catch {
                        throw "Failed to move file `"${FileDownloadTempPath64}`" to `"${FileDestinationPath64}`" with error: $_"
                    }
                }

                # Write the new version to the console
                Write-Output "Updated to version $ProductVersion"

                # Delete any nupkg files in the package folder if it exists
                $nupkgFiles = Get-ChildItem -Path $ScriptPath -Filter "$PackageName.*.nupkg" -File
                if ($nupkgFiles) {
                    foreach ($nupkgFile in $nupkgFiles) {
                        Write-Output "Deleting old nupkg file: $nupkgFile"
                        Remove-Item -Path $nupkgFile.FullName -Force
                    }
                }

                # Run 'choco pack' to create the nupkg file
                Write-Output "Creating nupkg file..."
                choco pack

                # If AutoPush is enabled, push the package to Chocolatey
                if ($AutoPush) {
                    $filename = "$PackageName.$ProductVersion.nupkg"
                    Write-Output "Pushing $filename to Chocolatey..."
                    choco push $filename
                }

                # Determine the push status
                $pushStatus = if ($AutoPush) { "Pushed: TRUE" } else { "Pushed: FALSE" }

                # Send an alert if enabled
                Write-Debug "Sending alert..."
                $alertMessage = "$PackageName has been updated to version $ProductVersion.`n$pushStatus"
                SendAlert -Subject "$PackageName Package Updated" -Message $alertMessage -Alert $Alert -EnvFilePath $EnvFilePath
            } else {
                # Package is up to date
                Write-Output "No update needed. No alert sent."
            }
        } else {
            # Invalid version format
            Write-Output "Invalid version format. Skipping update."

            # Send an alert if enabled
            Write-Debug "Sending package error alert..."
            SendAlert -Subject "$PackageName Package Error" -Message "$PackageName detected an invalid version format. Please check the update script and files." -Alert $Alert -EnvFilePath $EnvFilePath
        }
    } catch {
        # Send an alert if enabled
        Write-Debug "Sending package error alert..."
        SendAlert -Subject "$PackageName Package Error" -Message "$PackageName had an error when checking for updates. Please check the update script and files.`n`nError: $_" -Alert $Alert -EnvFilePath $EnvFilePath

        # Write the error to the console
        Write-Warning "An error occurred: $_"
        Write-Warning "Line number : $($_.InvocationInfo.ScriptLineNumber)"
    } finally {
        CleanupFileDownload
        Write-Output "Done."

        # Return to the original directory
        Pop-Location
    }
}

Write-Output ""