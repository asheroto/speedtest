[![GitHub Release Date - Published_At](https://img.shields.io/github/release-date/asheroto/speedtest)](https://github.com/asheroto/speedtest/releases)
[![GitHub Downloads - All Releases](https://img.shields.io/github/downloads/asheroto/speedtest/total)](https://github.com/asheroto/speedtest/releases)
[![GitHub Sponsor](https://img.shields.io/github/sponsors/asheroto?label=Sponsor&logo=GitHub)](https://github.com/sponsors/asheroto)
<a href="https://ko-fi.com/asheroto"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-Fi Button" height="20px"></a>

# Quickly run Speedtest.net test from the command line

This PowerShell script runs Speedtest.net's [Speedtest CLI](https://www.speedtest.net/apps/cli) from the command line. No need to browse to a website or unzip files, it does it all for you. Arguments are passed through to the CLI, so you arguments as you normally would.

> [!NOTE]
> This package nor its author are affiliate with Ookla or Speedtest.net. It is simply a wrapper around their CLI.

## How it works

-   Scrapes [Speedtest CLI](https://www.speedtest.net/apps/cli) download page for the latest version
-   Downloads the latest version
-   Unzips the file
-   Runs the speedtest.exe file
-   Cleans up the files

## License Information

> [!WARNING]  
> Your use of this script constitutes acceptance of EULA, Terms of Use, and the Privacy Policy. The script will automatically accept these on your behalf via CLI using `--accept-license` and `--accept-gdpr`. Please do not use the script if you do not agree.

License information is available by running the `speedtest.exe` without any arguments (not this script but the actual executable). Text may not appear for users in the United States.

```
You may only use this Speedtest software and information generated
from it for personal, non-commercial use, through a command line
interface on a personal computer. Your use of this software is subject
to the End User License Agreement, Terms of Use and Privacy Policy at
these URLs:

https://www.speedtest.net/about/eula
https://www.speedtest.net/about/terms
https://www.speedtest.net/about/privacy

Ookla collects certain data through Speedtest that may be considered
personally identifiable, such as your IP address, unique device
identifiers or location. Ookla believes it has a legitimate interest
to share this data with internet providers, hardware manufacturers and
industry regulators to help them understand and create a better and
faster internet. For further information including how the data may be
shared, where the data may be transferred and Ookla's contact details,
please see our Privacy Policy at:

http://www.speedtest.net/privacy
```

Please note this package nor its author are affiliate with Ookla or Speedtest.net. It is simply a wrapper around their CLI.

## Usage

The URL [asheroto.com/speedtest](https://asheroto.com/speedtest) always redirects to the [latest code-signed release](https://github.com/asheroto/speedtest/releases/latest/download/speedtest.ps1) of the script.

### PowerShell

Simply run this command with **PowerShell**.

```powershell
irm asheroto.com/speedtest | iex
```

Due to the nature of how PowerShell works, passing arguments to the script is a bit harder. To do it as a one-line command, you can run this:

```powershell
iex "& { $(iwr asheroto.com/speedtest) } --servers"
```

Or if you download the latest version, you can run it like this:

```powershell
.\speedtest.ps1
```

### Command Prompt

You can also run this command with **Command Prompt** by having it run PowerShell.

```bat
powershell -c "irm asheroto.com/speedtest | iex"
```

Due to the nature of how PowerShell works, passing arguments to the script is a bit harder. To do it as a one-line command, you can run this:

```bat
powershell -c "iex ""& { $(iwr asheroto.com/speedtest) } --servers"""
```

Or if you download the latest version, you can run it like this:

```bat
powershell -c ".\speedtest.ps1"
```

## Parameters

You can use `--help` to see the parameters available in the Speedtest CLI.

```powershell
Speedtest by Ookla is the official command line client for testing the speed and performance of your internet connection.

Version: speedtest 1.2.0.84

Usage: speedtest [<options>]
  -h, --help                        Print usage information
  -V, --version                     Print version number
  -L, --servers                     List nearest servers
  -s, --server-id=#                 Specify a server from the server list using its id
  -I, --interface=ARG               Attempt to bind to the specified interface when connecting to servers
  -i, --ip=ARG                      Attempt to bind to the specified IP address when connecting to servers
  -o, --host=ARG                    Specify a server, from the server list, using its host's fully qualified domain name
  -p, --progress=yes|no             Enable or disable progress bar (Note: only available for 'human-readable'
                                    or 'json' and defaults to yes when interactive)
  -P, --precision=#                 Number of decimals to use (0-8, default=2)
  -f, --format=ARG                  Output format (see below for valid formats)
      --progress-update-interval=#  Progress update interval (100-1000 milliseconds)
  -u, --unit[=ARG]                  Output unit for displaying speeds (Note: this is only applicable
                                    for ΓÇÿhuman-readableΓÇÖ output format and the default unit is Mbps)
  -a                                Shortcut for [-u auto-decimal-bits]
  -A                                Shortcut for [-u auto-decimal-bytes]
  -b                                Shortcut for [-u auto-binary-bits]
  -B                                Shortcut for [-u auto-binary-bytes]
      --selection-details           Show server selection details
  -v                                Logging verbosity. Specify multiple times for higher verbosity
      --output-header               Show output header for CSV and TSV formats

 Valid output formats: human-readable (default), csv, tsv, json, jsonl, json-pretty

 Machine readable formats (csv, tsv, json, jsonl, json-pretty) use bytes as the unit of measure with max precision

 Valid units for [-u] flag:
   Decimal prefix, bits per second:  bps, kbps, Mbps, Gbps
   Decimal prefix, bytes per second: B/s, kB/s, MB/s, GB/s
   Binary prefix, bits per second:   kibps, Mibps, Gibps
   Binary prefix, bytes per second:  kiB/s, MiB/s, GiB/s
   Auto-scaled prefix: auto-binary-bits, auto-binary-bytes, auto-decimal-bits, auto-decimal-bytes
```
