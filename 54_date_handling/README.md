# README

Demonstrate date handling in shell.  

## Prereqs

```sh
brew install coreutils
```

## GNU

```sh
gdate

# convert timestamp back to datetime
gdate --date=@1631891616

# date two days ago
gdate --date="2 days ago"

# date two days ago as timestamp
gdate --date="2 days ago" '+%s'
```

## MacOSX

```sh
# date yesterday as timestamp
date -v-1d '+%s'
```

## Resources

* How To Format Date And Time In Linux, MacOS, And Bash? [here](https://www.shell-tips.com/linux/how-to-format-date-and-time-in-linux-macos-and-bash/)
