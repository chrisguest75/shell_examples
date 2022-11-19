# README

TODO:

* Find code for my envelope encryption for mysql.
* Do a version with shared storage that does not require manual intervention

## Pass a file securely between two containers.

1) Why revocation key?

## Alice

Build and run the container

```sh
# Build 
docker build -t alice -f Dockerfile.alice .

# run alice
docker run -it --entrypoint /bin/sh alice
```

```sh
# Batch it instead of `gpg --full-generate-key`
# NOTE: passphrase
cat >key-settings <<EOF
     %echo Generating a basic OpenPGP key
     Key-Type: DSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: Alice
     Name-Comment: no-comment
     Name-Email: alice@alice.com
     Expire-Date: 1
     Passphrase: alice
     %commit
     %echo done
EOF

gpg --batch --generate-key key-settings
```

```sh
# Print out the key
gpg --export --armor alice@alice.com
```

## Bob

Build and run the container

```sh
# Build 
docker build -t bob -f Dockerfile.bob .

# run bob
docker run -it --entrypoint /bin/sh bob
```

```sh
# Batch it instead of `gpg --full-generate-key`
# NOTE: passphrase
cat >key-settings <<EOF
     %echo Generating a basic OpenPGP key
     Key-Type: DSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: Bob
     Name-Comment: no-comment
     Name-Email: bob@bob.com
     Expire-Date: 1
     Passphrase: bob
     %commit
     %echo done
EOF

gpg --batch --generate-key key-settings

# show outputs
ls /root/.gnupg
```

```sh
# Print out the key
gpg --export --armor bob@bob.com
```

## Exchange keys

On alice machine

```sh
# copy the key from bob machine into nano
nano ./bob.armor.gpg 

# import bob
gpg --import ./bob.armor.gpg 
```

```sh
# Get some data
curl -s -o ./source.txt http://metaphorpsum.com/paragraphs/2  

# need trust model always to prevent question
# use alice passsphrase
gpg -se -r bob@bob.com --trust-model always ./source.txt 

# base64 it so we can copy it in terminal
cat source.txt.gpg | base64 
```

On bob machine

```sh
# copy the base64 data from alice terminal
nano source.txt.gpg.b64

# back to binary
cat source.txt.gpg.b64 | base64 -d > source.txt.gpg

# decrypt (requires bob password for key)
gpg --decrypt source.txt.gpg
```
