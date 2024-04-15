This is a repository for the deployment of [iVentoy](https://www.iventoy.com) with [Chocolatey](https://chocolatey.org/).

Chocolatey Package URL: https://community.chocolatey.org/packages/iventoy

---

## Package Note

Starting with version `1.0.20`, iVentoy will now be installed to `$env:ChocolateyInstall\lib\iventoy`. This change was made because Chocolatey is intended to be used in a multi-user environment. Before this version, the package installation script was placing iVentoy in `$env:LocalAppData\iventoy`, which is limited to the current user only.

**iso folder moved:** The `iso` folder will be moved to this new location and will not be deleted.
**iso folder retention on uninstall:** If you choose to uninstall iVentoy, the `iso` folder will not be deleted.