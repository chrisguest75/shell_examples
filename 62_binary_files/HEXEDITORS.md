# README

Demonstrate some gui based hex editors.  

## Okteta

Okteta is a simple editor for the raw data of files.  

NOTE: It is not available on MacOSX  

```sh
# debian
sudo apt install okteta
```

## Radare

Radare2: Libre Reversing Framework for Unix Geeks  

```sh
# debian
sudo apt install radare2 

# macosx  
brew install radare2     

r2 $(which ps)
```

## imhex

NOTE: I was having issues installing on Ubuntu - Installed v1.18.2, GLIBCXX_3.4.29 missing

```sh
# debian
sudo dpkg -i ~/Downloads/imhex-1.19.3.deb

# macosx
brew install imhex
```

## Resources

* Okteta is a simple editor for the raw data of files. [here](https://apps.kde.org/en-gb/okteta/)
* Radare2: Libre Reversing Framework for Unix Geeks [here](https://github.com/radareorg/radare2)
* A Hex Editor for Reverse Engineers, Programmers and people who value their retinas when working at 3 AM. [here](https://github.com/WerWolv/ImHex)
* Hex patterns, include patterns and magic files for the use with the ImHex Hex Editor [here](https://github.com/WerWolv/ImHex-Patterns)
* Where can I find GLIBCXX_3.4.29? [here](https://stackoverflow.com/questions/65349875/where-can-i-find-glibcxx-3-4-29)
* How to install GLIBCXX_3.4.29 on Ubuntu 20.04? [here](https://askubuntu.com/questions/1393285/how-to-install-glibcxx-3-4-29-on-ubuntu-20-04)
* “PPA for Ubuntu Toolchain Uploads (restricted)” team [here](https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/glibc)
