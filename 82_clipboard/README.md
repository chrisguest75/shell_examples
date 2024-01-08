# CLIPBOARD

Examples of using clipboard in the shell  

Both Mac and Windows come with cmd tooling to help with copying to the clipboard.   

## MacOS

```sh
pbcopy

pbpaste
```

## Windows

```sh
# you need to quote !! after it expands
echo !! | clipcopy

# to paste
clippaste
# or to execute
$(clippaste)
```

## Resources

* Window subsytem for linux (WSL) copy to clipboard from the command line? [here](https://superuser.com/questions/1688736/window-subsytem-for-linux-wsl-copy-to-clipboard-from-the-command-line)
