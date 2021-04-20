# README
Demonstrate examples of working with APT and DPKG

Debian package repository example [README.md](../09_deb_pkg/README.md)  

TODO:
* apt-utils

## APT
Aptitude management

```sh
# version of apt
apt-get --version

# man pages for apt
man apt 

# update the indices
apt update

# search for packages
apt search apt-

# list installed packages
apt list --installed

# packages that can be upgraded
apt list --upgradable

# upgrade packages
apt upgrade
```

### List sources
```sh
# show the sources
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d

# show the source that a package comes from
apt policy apt-file

# the package does not need to be installed 
apt policy imagemagick
```

### List keys
```sh
apt-key list
```

### Add and remove a source
A lot of examples to add sources use the main sources file.  
```sh
# edit the /etc/apt/sources.list
sudo apt edit-sources

# example of creating .list file
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
```

### List contents of a apt package.
```sh
# install apt file 
apt install apt-file

# update and list - package does not need to be installed. 
apt-file update
apt-file list cgroup-tools
```

## DPKG

```sh
# install a package
dpkg -i ~/Downloads/virtualbox-6.1_6.1.16-140961_Ubuntu_eoan_amd64.deb
```

```sh
# list content and install location of package
dpkg -L bpfcc-tools
```

## HTTPS Sources
We can trust the Release file because it was signed by Ubuntu. We can trust the Packages file because it has the correct size and checksum found in the Release file. We can trust the package we just downloaded because it is referenced in the Packages file, which is referenced in the Release file, which is signed by Ubuntu. [From](https://www.reddit.com/r/linux/comments/aidxwa/why_does_apt_not_use_https/)

But people can still spy on what packges and versions you are installing.   

```sh
# see the https protocol
ls -la /usr/lib/apt/methods

# https is built into some versions so this may not be required >1.5.
sudo apt install apt-transport-https

# edit the /etc/apt/sources.list to https
sudo apt edit-sources

# THIS FAILS WITH A TLS ERROR
sudo apt update
```



## Resources

* [apt-transports](https://blog.cloudflare.com/apt-transports/)
* [wikipedia](https://en.wikipedia.org/wiki/APT_\(software\))
* [apt repo](https://salsa.debian.org/apt-team/apt)
* [changelog](https://salsa.debian.org/apt-team/apt/-/blob/main/debian/changelog)
* [apt-rce](https://justi.cz/security/2019/01/22/apt-rce.html)
* [why_does_apt_not_use_https](https://www.reddit.com/r/linux/comments/aidxwa/why_does_apt_not_use_https/)
* [why-arent-application-downloads-routinely-done-over-https](https://security.stackexchange.com/questions/18853/why-arent-application-downloads-routinely-done-over-https/18861#18861)