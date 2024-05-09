# ZSH SNIPPETS

## Corrupted zsh_history

WSL crashed on me and left my zsh history in a complete state and failing to run commands.  

Performing the following actions fixed my shell.  

```sh
cd ~
mv .zsh_history .zsh_history_bad
strings .zsh_history_bad > .zsh_history
fc -R .zsh_history
rm ~/.zsh_history_bad
```

## Resources

* How to fix a corrupt zsh history file [here](https://shapeshed.com/zsh-corrupt-history-file/)