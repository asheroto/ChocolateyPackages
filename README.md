[![GitHub Sponsor](https://img.shields.io/github/sponsors/asheroto?label=Sponsor&logo=GitHub)](https://github.com/sponsors/asheroto?frequency=one-time&sponsor=asheroto)
<a href="https://ko-fi.com/asheroto"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-Fi Button" height="20px"></a>
<a href="https://www.buymeacoffee.com/asheroto"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=seb6596&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&emoji=&slug=asheroto&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff)" height="40px"></a>

# Chocolatey Packages

This is the repository for the [Chocolatey](https://chocolatey.org/) packages that I maintain.

You can find the packages I maintain [here](https://community.chocolatey.org/profiles/asheroto).

## Updates

Each Wednesday and Saturday, my [PowerShell script](https://github.com/asheroto/ChocolateyPackages/blob/master/UpdateAll.ps1) will automatically update all packages that are out of date and push them to the repository. I also use [VisualPing.io](https://visualping.io) to monitor changes to certain packages and update them accordingly.

If you notice an outdated package and want to request an update:
- Verify there is not a pending version in the `Version History` section of the Chocolatey package on the [Chocolatey Community Repository](https://community.chocolatey.org/packages)
- After a newer version of the software has been released, please wait a few days for me to update the package (usually within a day or two)
- If the package is still outdated, open an [Issue](../../issues) and I'll address it

![image](https://github.com/asheroto/ChocolateyPackages/assets/49938263/d64649db-1b5f-4f8b-aae3-37313e4adb8f)

For updating packages, I use [Chocolatey Package Updater](https://github.com/asheroto/Chocolatey-Package-Updater), which is my solution inspired by the now archived [AU](https://github.com/majkinetor/au) repository.

> [!NOTE]
> In this repository, [Chocolatey-Package-Updater.ps1](https://github.com/asheroto/ChocolateyPackages/blob/master/Chocolatey-Package-Updater.ps1) is a symbolic link to the [actual script](https://github.com/asheroto/Chocolatey-Package-Updater/blob/main/Chocolatey-Package-Updater.ps1) in the Chocolatey Package Updater repository.

## Package Issues

If you have an issue with a package, please open an [Issue](../../issues).