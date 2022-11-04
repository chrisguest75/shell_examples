# ALIASES

Show some aliases and how to use them.  

TODO:  

* git diff $(git branch --show-current) origin/$(git branch --show-current)  

## List

```sh
# show the aliases
git alias  
```

## Aliases

```sh
# show pretty history
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
```
