# README 
TODO: Find code for my envelope encryption for mysql.


```sh
sudo apt-get install gpg

```
## Generate keys

```sh
docker build -t gpg_generate_keys -f Dockerfile.key_generation .
```

## Encrpyt a file

```sh
gpg --gen-key

curl -s -o ./source.txt http://metaphorpsum.com/paragraphs/2  

gpg -e -r "backup" ./source.txt
```

## Decrypt file

