# README

Demonstrate some `tmux` examples and common commands.  

## Background

tmux, short for "terminal multiplexer", is a powerful command-line tool used in Unix and Unix-like operating systems. It provides several functionalities that are extremely useful for users who work extensively with terminal sessions, especially when managing multiple tasks or connections simultaneously. Here's a breakdown of its key purposes and features:  

* Multiple Terminal Sessions in a Single Window: tmux allows you to create, manage, and navigate multiple terminal sessions from a single window. This is particularly useful for users who work on servers or remote machines via the command line.  

* Persistent Sessions: One of the primary features of tmux is its ability to maintain persistent sessions. This means you can start a session, detach from it, and then reattach later, with all your work preserved. This is especially useful for running long-term processes on a remote server.  

* Splitting Windows: tmux supports splitting the terminal window into multiple panes, both horizontally and vertically. This allows you to view and work in several shells simultaneously within the same window.  

* Customizable Status Bar: The status bar at the bottom of the tmux window provides useful information like session names, window lists, and can even display system information. It's highly customizable.  

* Scripting and Automation: Advanced users can write scripts for tmux to automate repetitive tasks, making their workflow more efficient.  

* Session Sharing: tmux sessions can be shared between multiple users, which is useful for collaborative work or for educational purposes where one might need to demonstrate commands and processes in real-time.  

* Enhanced Navigation: With tmux, you can easily navigate between different windows and panes, which is a big productivity boost compared to using multiple terminal windows or tabs.  

* Buffer and Clipboard Management: tmux allows you to copy text within a pane and paste it into another pane or window, providing an internal clipboard functionality.  

* Customization and Configuration: Users can customize almost every aspect of tmux, from keybindings to appearance, through a .tmux.conf file in the user's home directory.  

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

Keys                 | Description |
----                 | ---- |
`ctrl+b`             | tmux prefix - signal to the tmux process |
`ctrl+b + ?`         | Brings up help |
`ctrl+b + \"`        | Split screen horizontally | 
`ctrl+b + %`         | Split screen vertically | 
`ctrl+b + d`         | Detach from a session | 
`ctrl+b + s`         | List sessions and preview | 
`ctrl+b + $`         | Rename a session |
`ctrl+b + arrow key` | Switch to a pane | 
`ctrl+b + x`         | Kill a pane with confirmation |
`ctrl+d`             | Kill a pane instantly | 
`ctrl+b + z`         | Zoom into a window. |
`ctrl+b + c`         | Create new window |
`ctrl+b + p`         | Previous window |
`ctrl+b + n`         | Next Window |
`ctrl+b + &`         | Kill Window |
`ctrl+b + ,`         | Rename a window |
`ctrl+b + w`         | List windows | 
`ctrl+b + ,`         | Rename windows |

## iterm2

You can kill iterm window and then reopen using tmux attach  

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
* Everything you need to know about tmux – Plugins Manager [here](https://arcolinux.com/everything-you-need-to-know-about-tmux-plugins-manager/)
* jasonmorganson/dotfiles tmux plugins [here](https://github.com/jasonmorganson/dotfiles/blob/master/dot_tmux-plugins)
* tmux plugins list [here](https://github.com/tmux-plugins/list)  
