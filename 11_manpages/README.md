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
sudo mkdir -p /usr/local/man/man1      
install -g 0 -o 0 -m 0644 ./example-script.troff /usr/local/man/man1/example-script.1
gzip /usr/local/man/man1/example-script.1
man example-script
```

