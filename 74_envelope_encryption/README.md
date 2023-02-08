# README

Demonstrate how to perform envelope encryption.  

Envelope encryption is a method of encrypting data where the data is encrypted with a data key, and the data key is then encrypted with a separate key (typically a key-encryption key or KEK) before being stored along with the encrypted data. This way, the KEK can be used to encrypt and decrypt the data key, while the data key is used to encrypt and decrypt the actual data. The advantage of this approach is that it allows different keys to be used for different purposes, such as protecting data keys from unauthorized access or allowing data keys to be rotated without affecting the encrypted data.  

## Reason

We create a simple symmetric key that we use to encrypt a large file.  The key is encrypted using a public and put into a tarball with the data.  On reciept of the file we use the private key to decrypt the symmetric key and then decrypt the large file.  

We also use envelope encryption as the maximum size of the data that you can encrypt varies with the type of KMS key and the encryption algorithm that you choose.  All are very small number of bytes.  (Max asymmetric ~450bytes)  

## Generate a private/public key pair

```sh
KEYSPATH="./keys/"
mkdir -p "${KEYSPATH}"

# generate private key
openssl genrsa -out ${KEYSPATH}private.pem 4096
# show private key
openssl rsa -in ${KEYSPATH}private.pem -noout -text
# extract public key
openssl rsa -in ${KEYSPATH}private.pem -pubout > ${KEYSPATH}public.pem
# show public key
openssl rsa -in ${KEYSPATH}public.pem -pubin -text -noout
```

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
openssl rsautl -encrypt -inkey ${KEYSPATH}public.pem -pubin -in ${ENCRYPTPATH}${BACKUPFILE}.key -out "${ENCRYPTPATH}${BACKUPFILE}.key.enc"

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
openssl rsautl -decrypt -inkey ${KEYSPATH}private.pem -in "${DECRYPTPATH}${BACKUPFILE}.key.enc" > "${DECRYPTPATH}${BACKUPFILE}.key.dec"

openssl enc -d -aes-256-cbc -in "${DECRYPTPATH}${BACKUPFILE}.tar.enc" -pass "file:${DECRYPTPATH}${BACKUPFILE}.key.dec" -md sha256 > "${DECRYPTPATH}${BACKUPFILE}.dec.tar"

rm -f "${DECRYPTPATH}${BACKUPFILE}.tar.enc"
rm -f "${DECRYPTPATH}${BACKUPFILE}.key.dec"
rm -f "${DECRYPTPATH}${BACKUPFILE}.key.enc"

tar -C "${DECRYPTPATH}" -xvf "${DECRYPTPATH}${BACKUPFILE}.dec.tar"
```

## Resources

* Encrypting and decrypting files with OpenSSL [here](https://opensource.com/article/21/4/encryption-decryption-openssl)  
