# SCREEN

Demonstrate some `screen` examples and common commands.  

## Background

The screen tool on Linux is a powerful utility that allows users to manage multiple terminal sessions from a single console. It's particularly useful in various scenarios, such as:  

* Persistent Sessions: screen can keep sessions running even when the user disconnects from the server. This is especially useful for long-running processes; you can start a process inside a screen session, detach from it, and then reconnect later to check the progress.  

* Multiple Windows: Users can create multiple windows within a single screen session. This allows for multitasking within the same SSH or terminal session. You can switch between these windows, similar to tabs in a modern web browser.

* Session Sharing: screen allows multiple users to view and interact with the same session, which is useful for collaborative work or for demonstrating something to another user.

* Session Recovery: If your connection to a remote server is interrupted (like through an SSH session), the processes running in screen will not be terminated. You can simply reconnect and resume where you left off.

* Scripting and Automation: screen can be used in scripts to automate tasks across multiple windows or sessions.

## Screen

| Command      | Description       |
| -------      | ---------         |
| `screen -ls` | List sessions     |
| `screen`     | Start a session   |
| `screen -r`  | Restore a session |

## Keys

| Command    | Description    |
| -------    | ---------      |
| `ctrl+d`   | Kill a session |
| `ctrl+a d` | Detach from a session |

## Example

```sh
# start sssh
ssh user@ip

# list sessions
screen -ls

# start a named sesssion
screen -S mytest

# on another machine attach (rd restore and detach others)
screen -rd <sessionid>

# get the current session id.
echo $STY    
```

## Monitor

```sh
# monitor another session
screen -x <sessionid>
```

## Resources
