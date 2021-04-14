# README
Demonstrate examples of working with APT and DPKG

TODO:
* How do I list packages in specific source?
*  

## APT
Aptitude management

```sh
man apt 

apt update

apt list --installed

apt list --upgradable

apt upgrade
```

### List sources
```sh
# show the sources
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d
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

