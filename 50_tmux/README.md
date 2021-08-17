# README
Demonstrate some tmux examples and common commands 

TODO:
* tmuxinator examples

## Configuration
Example in my dotfiles [here](https://github.com/chrisguest75/default_dotfiles/blob/master/tmux/.tmux.conf)

```sh
cat ~/.tmux.conf
```



## Sessions
```sh
# Start new session with directory name
tmux new -s $(basename $(pwd))	

# list open sessions
tmux list-sessions 
tmux ls	

# attach to a particular session
tmux attach -t <name>	

```

## Keys
```sh
ctrl+b + ? 	            Brings up help 

ctrl+b + \"             Split screen horizontally
ctrl+b + %	            Split screen vertically

ctrl+b + d 	            Detach from a session
ctrl+b + s	            List sessions and preview

ctrl+b                  tmux prefix - signal to the tmux process
ctrl+b + arrow key 	    Switch to a pane
ctrl+b + x	            Kill a pane with confirmation
ctrl+d 	                Kill a pane instantly
ctrl+b + z	            Zoom into a window.
ctrl+b + $ 	            Rename a session
ctrl+b + c	            Create new window
ctrl+b + p	            Previous window
ctrl+b + n 	            Next Window
ctrl+b + &	            Kill Window
ctrl+b + ,	            Rename a window
ctrl+b + w              List windows
ctrl+b + ,              Rename windows
```

I can kill iterm window and then reopen using tmux attach 


# Resources 

* tmux key bindings example [here](https://zserge.com/posts/tmux/)
* `cheatsheet tmux`
* `man tmux`
* tmux config blog [here](https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/)
* getting started with tmux [here](https://linuxize.com/post/getting-started-with-tmux/)
* tmuxcheatsheet [here](https://tmuxcheatsheet.com/)
