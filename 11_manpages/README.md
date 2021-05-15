# README
Demonstrate how to create a manpage. 

## Prequisites 
1. Install vscode extension for manpage troff syntax highlighting
    ```sh
    code --install-extension ban.troff
    ```

## Example
Open the page in man pages.
```sh
man ./example-script.troff  
```

Install the man page
```sh
# create manpage folder
sudo mkdir -p /usr/local/man/man1  
# use 'install' to copy manpage     
install -g 0 -o 0 -m 0644 ./example-script.troff /usr/local/man/man1/example-script.1
# gzip it
gzip /usr/local/man/man1/example-script.1
# print manpage for your script
man example-script
```

