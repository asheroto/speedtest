<#PSScriptInfo

.VERSION 0.0.3

.GUID a4af5e07-d626-4b97-b4d6-eef7265d1f7c

.AUTHOR asheroto

.COMPANYNAME asheroto

.TAGS PowerShell speedtest speed test speedtest.net

.PROJECTURI https://github.com/asheroto/speedtest

.RELEASENOTES
[Version 0.0.1] - Initial Release.
[Version 0.0.2] - Added UseBasicParsing parameter to Invoke-WebRequest commands to fix issue with certain systems.
[Version 0.0.3] - Adjusted to work with GDPR acceptance.

#>

<#
.SYNOPSIS
	Downloads and runs the Speedtest.net CLI client.
.DESCRIPTION
	Downloads and runs the Speedtest.net CLI client.

Designed to use with short URL to make it easy to remember.
.EXAMPLE
	speedtest.ps1
.PARAMETER Version
    Displays the version of the script.
.PARAMETER Help
    Displays the full help information for the script.
.NOTES
	Version      : 0.0.3
	Created by   : asheroto
.LINK
	Project Site: https://github.com/asheroto/speedtest
#>
param (
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$ScriptArgs
)

# Version
$CurrentVersion = '0.0.3'
$RepoOwner = 'asheroto'
$RepoName = 'speedtest'
$PowerShellGalleryName = 'speedtest'

# Versions
$ProgressPreference = 'SilentlyContinue' # Suppress progress bar (makes downloading super fast)
$ConfirmPreference = 'None' # Suppress confirmation prompts

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

# Display $PSVersionTable and Get-Host if -Verbose is specified
if ($PSBoundParameters.ContainsKey('Verbose') -and $PSBoundParameters['Verbose']) {
    $PSVersionTable
    Get-Host
}

# ============================================================================ #
# Startup
# ============================================================================ #

# Scrape the webpage to get the download link
function Get-SpeedTestDownloadLink {
    $url = "https://www.speedtest.net/apps/cli"
    $webContent = Invoke-WebRequest -Uri $url -UseBasicParsing
    if ($webContent.Content -match 'href="(https://install\.speedtest\.net/app/cli/ookla-speedtest-[\d\.]+-win64\.zip)"') {
        return $matches[1]
    } else {
        Write-Output "Unable to find the win64 zip download link."
        return $null
    }
}

# Download the zip file
function Download-SpeedTestZip {
    param (
        [string]$downloadLink,
        [string]$destination
    )
    Invoke-WebRequest -Uri $downloadLink -OutFile $destination -UseBasicParsing
}

# Extract the zip file
function Extract-Zip {
    param (
        [string]$zipPath,
        [string]$destination
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $destination)
}

# Run the speedtest executable
function Run-SpeedTest {
    param (
        [string]$executablePath,
        [array]$arguments
    )

    # Check if '--accept-license' is already in arguments
    if (-not ($arguments -contains "--accept-license")) {
        $arguments += "--accept-license"
    }

    # Check if '--accept-gdpr' is already in arguments
    if (-not ($arguments -contains "--accept-gdpr")) {
        $arguments += "--accept-gdpr"
    }

    & $executablePath $arguments
}


# Cleanup
function Remove-File {
    param (
        [string]$Path
    )
    try {
        if (Test-Path -Path $Path) {
            Remove-Item -Path $Path -Recurse -ErrorAction Stop
        }
    } catch {
        Write-Debug "Unable to remove item: $_"
    }
}

function Remove-Files {
    param(
        [string]$zipPath,
        [string]$folderPath
    )
    Remove-File -Path $zipPath
    Remove-File -Path $folderPath
}

# Main Script
try {
    $tempFolder = $env:TEMP
    $zipFilePath = Join-Path $tempFolder "speedtest-win64.zip"
    $extractFolderPath = Join-Path $tempFolder "speedtest-win64"

    Remove-Files -zipPath $zipFilePath -folderPath $extractFolderPath

    $downloadLink = Get-SpeedTestDownloadLink
    Write-Output "Downloading SpeedTest CLI..."
    Download-SpeedTestZip -downloadLink $downloadLink -destination $zipFilePath

    Write-Output "Extracting Zip File..."
    Extract-Zip -zipPath $zipFilePath -destination $extractFolderPath

    $executablePath = Join-Path $extractFolderPath "speedtest.exe"
    Write-Output "Running SpeedTest..."
    Run-SpeedTest -executablePath $executablePath -arguments $ScriptArgs

    Write-Output "Cleaning up..."
    Remove-Files -zipPath $zipFilePath -folderPath $extractFolderPath

    Write-Output "Done."
} catch {
    Write-Error "An error occurred: $_"
}