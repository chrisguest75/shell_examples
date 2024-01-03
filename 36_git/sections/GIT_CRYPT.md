# GIT-CRYPT

Demonstrate how to use `git-crypt` on a repo

## Contents

- [GIT-CRYPT](#git-crypt)
  - [Contents](#contents)
  - [Prereqs](#prereqs)
  - [Enable](#enable)
  - [Encrypting key file](#encrypting-key-file)
  - [Rotate key git-crypt](#rotate-key-git-crypt)
  - [Unlock the repo with the wrong key](#unlock-the-repo-with-the-wrong-key)
  - [Resources](#resources)

TODO:

* Push to github and see encryption
* Rotate a key. 
* gpg keys

## Prereqs

```sh
# info about git-crypt
brew info git-crypt   
apt list git-crypt

# install git-crypt
brew install git-crypt
# install on debian
apt install git-crypt
```

## Enable

```sh
git-crypt init 
git config --local --list

# exporting the key (store this safe)
git-crypt export-key ../git-crypt-key
```

## Encrypting key file

Transparently encrypt a file inside the repo.  

```sh
# create .gitattributes for key
echo "api.key filter=git-crypt diff=git-crypt" > .gitattributes
git add .gitattributes
git commit -m "Enable encryption for api.key"

# create a secret in the api.key file
echo "my secret value" > api.key
git add api.key
git commit -m "Commit api.key"

# give the status of the repo to indicate encryption status
git-crypt status

# or filter on a file
git-crypt status api.key

# file should be text file
cat api.key

# turn off git-crypt
git-crypt lock

# file is now random data
cat api.key

# turn on git-crypt
git-crypt unlock ../git-crypt-key
```

## Rotate key git-crypt

Rotate the key and encrpyt the file again.  

```sh
# turn off git-crypt
git-crypt lock

# reinitialising will generate a new key 
git-crypt init

# export the new key
git-crypt export-key ../git-crypt-key2

echo "new secret value" > api.key
cat api.key

git add api.key
git commit -m "Commit api.key"
```

## Unlock the repo with the wrong key

```sh
# turn off git-crypt
git-crypt lock

git-crypt unlock ../git-crypt-key

## Using keys is now broken (file will be removed)
git status

# does not work
git-crypt lock 
# you have to force removal
git-crypt lock --force

# Now you can reapply the correct key
git-crypt unlock ../git-crypt-key2

# decryption works
cat api.key
```

## Resources

* How to Manage Your Secrets with git-crypt [here](https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih)
* git-crypt - transparent file encryption in git [here](https://www.agwa.name/projects/git-crypt/)
* git-crypt repo [here](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md)
* Limitations [here](https://github.com/AGWA/git-crypt#limitations)  
