[![GitHub Release Date - Published_At](https://img.shields.io/github/release-date/asheroto/winget-installer)](https://github.com/asheroto/winget-installer/releases)
[![GitHub Downloads - All Releases](https://img.shields.io/github/downloads/asheroto/winget-installer/total)](https://github.com/asheroto/winget-installer/releases)
[![GitHub Sponsor](https://img.shields.io/github/sponsors/asheroto?label=Sponsor&logo=GitHub)](https://github.com/sponsors/asheroto)
<a href="https://ko-fi.com/asheroto"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-Fi Button" height="20px"></a>

# Quickly run Speedtest.net test from the command line

This is a simple PowerShell script that will run the [Speedtest.net CLI](https://www.speedtest.net/apps/cli) program from the command line. No need to browse to a website or unzip files, it does it all for you. Arguments are passed through to the CLI, so you arguments as you normally would.

## How it works

-   Scrapes the [Speedtest.net CLI](https://www.speedtest.net/apps/cli) download page for the latest version
-   Downloads the latest version
-   Unzips the file
-   Runs the speedtest.exe file
-   Cleans up the files

## Usage

Simply run this command with PowerShell. The URL [asheroto.com/speedtest](https://asheroto.com/speedtest) always points to the [latest version](https://raw.githubusercontent.com/asheroto/speedtest/main/speedtest.ps1) of the script.

```powershell
irm asheroto.com/speedtest | iex
```

Due to the nature of how PowerShell works, passing arguments to the script is a bit harder. To do it as a one-line command, you can run this:

```powershell
iex "& { $(iwr asheroto.com/speedtest) } --servers"
```

Or if you download the latest version, you can run it like this:

```powershell
.\speedtest.ps1 --servers
```