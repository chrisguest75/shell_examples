# LINE ENDINGS

Demonstrate some examples of working with line-endings differences.  

## Reason

When switching between WSL and Windows line endings will sometimes be converted.  

NOTES:

* It seems if VSCode detects line endings it continues to use that style.  

## VSCode Extension

Use a code extension to render the line endings.  

```sh
code --install-extension medo64.render-crlf
```

## Tools

```sh
sudo apt install dos2unix
```

## Start

```sh
# show line endings
cat --show-all ./dos.txt
# show file type
file ./dos.txt 


# show line endings
cat --show-all ./unix.txt
# show file type
file ./unix.txt 
```

## Convert

```sh
dos2unix ./dos.txt
cat --show-all ./dos.txt 

unix2dos ./unix.txt
cat --show-all ./unix.txt 
```

## Resources

* How to find out line-endings in a text file? [here](https://stackoverflow.com/questions/3569997/how-to-find-out-line-endings-in-a-text-file)  
