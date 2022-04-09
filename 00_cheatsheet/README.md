# README

Cheatsheets are a great way to quickly get an answer to your question.  

My personal [CHEATSHEET.md](./CHEATSHEET.md)  

## Cheat.sh

[cheat.sh](https://github.com/chubin/cheat.sh)  

```sh
# a quick function to simplify calling cheat.sh
function cheatsheet() {
	curl "cheat.sh/$1" 
}
```

## Examples

```sh
# main menu
cheatsheet 

# python questions
cheatsheet "python/open a file" 

# git rollback
cheatsheet "git/rollback" 
```

## Resources

Great resources for shell programming  

* [awesome-cheatsheets/bash](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh)  
* [shellmagic](https://shellmagic.xyz/)  
