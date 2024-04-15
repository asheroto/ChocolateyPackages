This is a repository for the deployment of [Ventoy](https://github.com/ventoy/Ventoy) with [Chocolatey](https://chocolatey.org/).

Chocolatey Package URL: https://community.chocolatey.org/packages/ventoy

---

## Package Note

Starting with version `1.0.97.20240415`, Ventoy will now be installed to `$env:ChocolateyInstall\lib\ventoy`. This change was made because Chocolatey is intended to be used in a multi-user environment. Before this version, the package installation script was placing Ventoy in `$env:LocalAppData\ventoy`, which is limited to the current user only.