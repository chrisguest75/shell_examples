# GIT-CRYPT

Demonstrate how to use `git-crypt` on a repo

TODO:

* Push to github and see encryption
* Rotate a key. https://github.com/AGWA/git-crypt#limitations

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
git-crypt export-key ./git-crypt-key
```

## Encrypting key

```sh
# create .gitattributes for key
echo "api.key filter=git-crypt diff=git-crypt" > .gitattributes

# create a secret in the api.key file
echo "my secret value" > api.key

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

## Resources

* How to Manage Your Secrets with git-crypt [here](https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih)
* git-crypt - transparent file encryption in git [here](https://www.agwa.name/projects/git-crypt/)
* git-crypt repo [here](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md)
