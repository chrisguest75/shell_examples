# README

Demonstrate some `tmux` examples and common commands.  

TODO:

* tmux in iterm

## Configuration

Example in my dotfiles [here](https://github.com/chrisguest75/default_dotfiles/blob/master/tmux/.tmux.conf)

```sh
cat ~/.tmux.conf
```

## Sessions

```sh
# version of tmux
tmux -V

# Start new session with directory name
tmux new -s $(basename $(pwd))	

# list open sessions
tmux list-sessions 
tmux ls	

# attach to a particular session
tmux attach -t <name>	

# kill a session and all windows
tmux kill-session -t <name>
```

## Keys

```sh
ctrl+b                  tmux prefix - signal to the tmux process

ctrl+b + ?              Brings up help 

ctrl+b + \"             Split screen horizontally
ctrl+b + %              Split screen vertically

ctrl+b + d              Detach from a session
ctrl+b + s              List sessions and preview
ctrl+b + $              Rename a session

ctrl+b + arrow key      Switch to a pane
ctrl+b + x              Kill a pane with confirmation
ctrl+d 	                Kill a pane instantly

ctrl+b + z              Zoom into a window.
ctrl+b + c              Create new window
ctrl+b + p              Previous window
ctrl+b + n              Next Window
ctrl+b + &              Kill Window
ctrl+b + ,              Rename a window
ctrl+b + w              List windows
ctrl+b + ,              Rename windows
```

## iterm2

You can kill iterm window and then reopen using tmux attach 

## tmuxinator

```sh
# install
brew install tmuxinator   

# create session (below for link to copy layout from existing session)
export EDITOR=nano 
tmuxinator new --local shell_examples      

# start a tmuxinator session
tmuxinator local

# detach from a session
ctrl+b + d             

tmux kill-session -t shell_examples
```

## plugins

```sh
# clone tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy over settings
cp ./.tmux.conf ~/.tmux.conf

# reload config
tmux source-file ~/.tmux.conf

# load the plugins
Press ctrl+b+I

# show downloaded plugin folders
ls ~/.tmux/plugins
```

## Resources 

* `cheatsheet tmux`
* `man tmux`
* tmux key bindings example [here](https://zserge.com/posts/tmux/)
* tmux config blog [here](https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/)
* getting started with tmux [here](https://linuxize.com/post/getting-started-with-tmux/)
* tmuxcheatsheet [here](https://tmuxcheatsheet.com/)
* Copying layout to tmuxinator [here](https://fabianfranke.de/use-tmuxinator-to-recreate-tmux-panes-and-windowstmuxinator-save-tmux-pane-and-window-layouts/)
* Everything you need to know about tmux – Plugins Manager [here](https://arcolinux.com/everything-you-need-to-know-about-tmux-plugins-manager/)
* jasonmorganson/dotfiles tmux plugins [here](https://github.com/jasonmorganson/dotfiles/blob/master/dot_tmux-plugins)
* tmux plugins list [here](https://github.com/tmux-plugins/list)  
