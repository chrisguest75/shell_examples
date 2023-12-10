# OS DETECTION

Demonstrate how to detect the OS type in script to change parameters to commands.  

## Contents

- [OS DETECTION](#os-detection)
  - [Contents](#contents)
  - [Example Script](#example-script)
    - [Docker](#docker)
  - [Ubuntu \& Debian](#ubuntu--debian)
  - [Alpine](#alpine)
  - [NixOS](#nixos)
  - [Fedora](#fedora)
  - [MacOS](#macos)
  - [Windows](#windows)
  - [Resources](#resources)

REF: [chrisguest75/docker_examples/10_distro_versions/README.md](https://github.com/chrisguest75/docker_examples/blob/master/10_distro_versions/README.md)  

## Example Script

```sh
# use decision logic based on OS version
./detect-os.sh  
```

### Docker

```sh
docker buildx build --progress=plain -f Dockerfile.os -t detect-os .
docker run --rm detect-os
```

## Ubuntu & Debian

```sh
# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apt list
apt update
apt list --upgradable
```

## Alpine

```sh
# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apk list --installed
apk list -u
```

## NixOS

```sh
# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
apk list --installed
apk list -u
```

## Fedora

```sh
# kernel versions
uname -a
cat /proc/version

# distro versions  
cat /etc/os-release

# package versions
yum list --installed
yum list --upgrades
```

## MacOS

```sh
sw_vers -productName
sw_vers -productVersion
sw_vers -buildVersion
echo "Hostname (VPN): $(scutil --get HostName)"
echo "LocalHostName: $(scutil --get LocalHostName)"  
```

## Windows

```sh
# in cmd prompt
ver

# versions in powershell
[System.Environment]::OSVersion
```

## Resources
