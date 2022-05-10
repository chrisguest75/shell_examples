# README

Demonstrate date handling in shell.  

## Prereqs

To get GNU `gdate` on a Mac you'll need to install `coreutils`

```sh
brew install coreutils
```

## GNU

```sh
# Tue May 10 08:56:10 BST 2022
gdate

# convert timestamp back to datetime "Fri Sep 17 16:13:36 BST 2021"
gdate --date=@1631891616

# date two days ago "Sun May  8 08:56:57 BST 2022"
gdate --date="2 days ago"

# date two days ago as timestamp "1651996634"
gdate --date="2 days ago" '+%s'

# Include nanoseconds "2022-05-10 08:57:25.611297000+01:00"
gdate --rfc-3339=ns 

# Include nanoseconds "1652169462.931413000"
gdate +%s.%N 
```

## MacOSX

```sh
# date yesterday as timestamp "1652083103"
date -v-1d '+%s'
```

## Resources

* How To Format Date And Time In Linux, MacOS, And Bash? [here](https://www.shell-tips.com/linux/how-to-format-date-and-time-in-linux-macos-and-bash/)
