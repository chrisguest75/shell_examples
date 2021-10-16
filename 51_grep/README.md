# README
Demonstrates examples of how to use grep.

```sh
grep --version    
```

## GNU grep
```sh
# install ggrep on macosx
brew install grep 
```

```sh
ggrep
```

Extract HTML links
```sh
cat ./patterns.html | ggrep -Po 'href="\K.*?(?=")' | grep ".*\.cells" | wc -l
```
# Resources
