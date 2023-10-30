Use Speedtest® for a quick, easy, one-tap connection internet speed test—accurate anywhere thanks to our global server network.

## Package Parameters
Command-line options for installer configuration:
- `/InstallDir:PATH`
- `/StartMenuShortcut` Create the Start Menu Shortcut

### Examples
- Install + start menu shortcut:
`choco install speedtest --params "/StartMenuShortcut"`
- Portable mode:
`choco install speedtest --params "/InstallDir:C:\speedtest"`

### Default Parameters
By default, **installation** of this package:
- Will be installed in Chocolatey tools directory.
- The Start menu shortcut is not created.

---

This is a repository for the deployment of [Speedtest by Ookla](https://www.speedtest.net/apps/cli) with [Chocolatey](https://chocolatey.org/).

Chocolatey Package URL: https://community.chocolatey.org/packages/speedtest