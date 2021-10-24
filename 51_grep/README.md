# README
Demonstrates examples of how to use grep.

```sh
grep --version    
```

## GNU grep
MacOs default `grep` is `bsd` if you need some of the fancy features of `gnu` grep then you'll need to install `ggrep` 
```sh
# install ggrep on macosx
brew install grep 
```

```sh
ggrep
```

Extract links from a scraped page. 
```sh
# get list of patterns 
curl -o ./conwaylife.html https://www.conwaylife.com/patterns/  

# extract only the *.cells filenames (using a Perl regexp)
cat ./conwaylife.html | ggrep -Po 'href="\K.*?(?=")' | grep ".*\.cells"
```
# Resources
