# TMUXINATOR

## Install

```sh
# install
brew install tmuxinator   
```

## Using

```sh
# create session (below for link to copy layout from existing session)
export EDITOR=nano 
tmuxinator new --local shell_examples      

# start a tmuxinator session
tmuxinator local

# detach from a session
ctrl+b + d             

tmux kill-session -t shell_examples
```

## Sessions

Open tmux and monitor gpu.  

```sh
# open tmux
just monitor-gpu
```

## Resources

* Copying layout to tmuxinator [here](https://fabianfranke.de/use-tmuxinator-to-recreate-tmux-panes-and-windowstmuxinator-save-tmux-pane-and-window-layouts/)