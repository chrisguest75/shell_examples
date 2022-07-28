# README

Demonstrates examples of how to use grep and regex.  

```sh
grep --version    
```

## GNU grep

MacOs default `grep` is `bsd` if you need some of the fancy features of `gnu` grep then you'll need to install `ggrep`  

```sh
# install ggrep on macosx
brew install grep 

# can now use ggrep
ggrep
```

## Common uses

```sh
# show lines before and after match
grep -A 10 -B 10

# OR has to be escaped.
grep "continuity\|PID"
```

## Perl grep expressions

Extract links from a scraped page.  

```sh
# get list of patterns 
curl -o ./conwaylife.html https://www.conwaylife.com/patterns/  

# extract only the *.cells filenames (using a Perl regexp)
cat ./conwaylife.html | ggrep -Po 'href="\K.*?(?=")' | grep ".*\.cells"
```

## Rematch

Use BASH_REMATCH.

```sh
# has to use bash not zsh
bash 
```

```sh
# split the paths
regex="(.*)/(.*)"
input=$(pwd)

if [[ $input =~ $regex ]]; then
  match1="${BASH_REMATCH[1]}"
  match2="${BASH_REMATCH[2]}"
  echo "'$input' has matched '$match1' '$match2'"
else
  echo "'$input' does not match"
fi
```

## Resources

* Bash Regular Expressions [here](https://www.linuxjournal.com/content/bash-regular-expressions)
