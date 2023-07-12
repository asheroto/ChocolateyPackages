This is a repository for the deployment of [uTorrent Classic](https://www.utorrent.com/) with [Chocolatey](https://chocolatey.org/).

Chocolatey Package URL: https://community.chocolatey.org/packages/uTorrent

## Package Note
uTorrent installer installs unwanted/questionable software by default, which can trigger A/V detections and is against the Chocolatey packaging guidelines.
This package installs uTorrent without the additional software. EULA allows for distribution.

The steps to download are listed below this section, but the details are contained herein:

You can get the latest web installer here:
```
https://www.utorrent.com/downloads/complete/track/stable/os/win/
```

That web installer downloads the **standlone installer** from here (**USE THIS**):
```
http://download-new.utorrent.com/endpoint/utorrent/os/riserollout/track/stable
```

The standalone installer is what is used in this package.

By default, the web installer will also download the **unwanted/questionable software** from here (**DON'T USE**):
```
https://darogjfc463nr.cloudfront.net/f/PlayaNext/files/1010/Standalone_Setup.zip
```
## Legal Note
The company name was changed from BitTorrent Inc to Rainberry Inc in 2017, but is the same application. [Source](https://torrentfreak.com/bittorrent-inc-changed-its-name-to-rainberry-180512/)

The metadata of the package EXE says the publisher is BitTorrent Inc, but the legal name & copyright is Rainberry Inc.

EULA source URL:
```
https://www.bittorrent.com/legal/eula
```

EULA source URL comes from the bottom of [uTorrent.com](https://www.utorrent.com/)