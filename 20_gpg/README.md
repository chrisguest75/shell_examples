# README 

```sh
sudo apt-get install gpg

```
## Generate keys and encrpyt a file

```sh
gpg --gen-key

curl -s -o ./source.txt http://metaphorpsum.com/paragraphs/2  

gpg -e -r "backup" ./source.txt
```

## Decrypt file

