# NOTABLE TOOLS

A collection of notes on some notable tools that can help with writing shell scripts. Each tool will have a quick description, where to find it and why it is useful.  

- [NOTABLE TOOLS](#notable-tools)
  - [Tools](#tools)
    - [Just](#just)
  - [Pipe Tools](#pipe-tools)
    - [subst and envsubst](#subst-and-envsubst)
    - [sponge](#sponge)
    - [numfmt](#numfmt)
    - [JQ and YQ](#jq-and-yq)
  - [Resources](#resources)

## Tools

### Just

`npm` has the concept of scripts that developers use to provide common tasks such as "build" and "run".  But when you're not in that ecosystem such as with `terraform` or `docker` then you find having to provide readme with quite complicated build commands or custom scripts. `just` allows a simple DSL to provide this functionality.  

Example [75_just/README.md](../75_just/README.md)  

## Pipe Tools

### subst and envsubst

Useful for creating configuration file templates and then processing them to replace strings with environment variable values.  

### sponge

Soak up standard input and write to a file. When processing configs files and templates. You'll sometimes want to replace in place.  

```sh
brew install "sponge or moreutils"
```

```sh
# this fails and empties the file
cat ./xml/results.hurl.xml | xmllint --format - > ./xml/results.hurl.xml

# using sponge fixes the issue
cat ./xml/results.hurl.xml | xmllint --format - | sponge ./xml/results.hurl.xml
```

### numfmt

numfmt - Convert numbers from/to human-readable strings.  

```sh
# 1,234,567
numfmt --grouping 1234567

# 1.3M
numfmt --to=si 1234567

# 1200000
numfmt --from=si 1.2M

#        123
numfmt --padding=10 123
```

### JQ and YQ

Example [32_jq/README.md](../32_jq/README.md)  
Example [42_yq_yaml/README.md](../42_yq_yaml/README.md)  

## Resources

* sponge - soak up standard input and write to a file [here](https://manpages.debian.org/testing/moreutils/sponge.1.en.html)  
