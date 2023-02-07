# README

Demonstrate how to perform envelope encryption.  

## Generate a private/public key pair


## Encrypt the file using symmetric key (the envelope)

```sh
BACKUPDATE=$(date -u +"%Y%m%d_%H%M%S_Z")
ENCRYPTPATH="./backup/"
echo "Create output folder ${ENCRYPTPATH}"
mkdir -p "${ENCRYPTPATH}"
BACKUPFILE=file_${BACKUPDATE}

# create content
curl -s -o "${ENCRYPTPATH}/source1.txt" http://metaphorpsum.com/paragraphs/2  
curl -s -o "${ENCRYPTPATH}/source2.txt" http://metaphorpsum.com/paragraphs/5  

# create key
openssl rand 256 > "${ENCRYPTPATH}${BACKUPFILE}.key"

# create tar file
tar  -C "${ENCRYPTPATH}" -f "${ENCRYPTPATH}${BACKUPFILE}.dec.tar" -cz "source1.txt" "source2.txt"  

# create encrypted file
cat "${ENCRYPTPATH}${BACKUPFILE}.dec.tar" | openssl enc -aes-256-cbc -salt -out "${ENCRYPTPATH}${BACKUPFILE}.tar.enc" -pass "file:${ENCRYPTPATH}${BACKUPFILE}.key" -md sha256  
```

## Encrypt the key using asymmetric key

```sh
# encrypt key (THIS IS WHERE WE SHOULD ENCRYPT USING AWS KEY)
cp ${ENCRYPTPATH}${BACKUPFILE}.key "${ENCRYPTPATH}${BACKUPFILE}.key.enc"

# put the key in second envelope
tar -C "${ENCRYPTPATH}" -cz -f "${ENCRYPTPATH}${BACKUPFILE}.final.tar" "${BACKUPFILE}.tar.enc" "${BACKUPFILE}.key.enc" 
```

## Decrypt

```sh
DECRYPTPATH="./output/"
echo "Create output folder ${DECRYPTPATH}"
mkdir -p "${DECRYPTPATH}"

# get encrypted file
cp "${ENCRYPTPATH}${BACKUPFILE}.final.tar" "${DECRYPTPATH}${BACKUPFILE}.final.tar"

tar -C "${DECRYPTPATH}" -xvf "${DECRYPTPATH}${BACKUPFILE}.final.tar" 

# encrypt key (THIS IS WHERE WE SHOULD DECRYPT USING AWS KEY)
cp "${DECRYPTPATH}${BACKUPFILE}.key.enc" "${DECRYPTPATH}${BACKUPFILE}.key.dec"

openssl enc -d -aes-256-cbc -in "${DECRYPTPATH}${BACKUPFILE}.tar.enc" -pass "file:${DECRYPTPATH}${BACKUPFILE}.key.dec" -md sha256 > "${DECRYPTPATH}${BACKUPFILE}.dec.tar"

rm -f "${DECRYPTPATH}${BACKUPFILE}.tar.enc"
rm -f "${DECRYPTPATH}${BACKUPFILE}.key.dec"
rm -f "${DECRYPTPATH}${BACKUPFILE}.key.enc"

tar -C "${DECRYPTPATH}" -xvf "${DECRYPTPATH}${BACKUPFILE}.dec.tar"
```

## Resources

* Encrypting and decrypting files with OpenSSL [here](https://opensource.com/article/21/4/encryption-decryption-openssl)  
