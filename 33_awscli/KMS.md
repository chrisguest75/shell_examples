# KEY MANAGEMENT SERVICE

Demonstrate how to work with KMS.  

```sh
# list keys
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms list-keys | jq .

# describe a particular key
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms describe-key --key-id "449A7AB4-6FFE-4AF5-845D-7E9A8E933713" | jq .
```

## Creation

```sh
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms create-key --key-usage ENCRYPT_DECRYPT --description "Test" --key-spec "RSA_4096"

# NOT WORKING
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" create-alias --alias-name mytestkey --target-key-id 5849c6ab-aace-4915-bfe1-dfffc7ee3b33
```

## Encrypt and Decrypt

```sh
PLAINTEXT=$(echo "hello world" | base64 )
BLOB=$(aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms encrypt --key-id "5849c6ab-aace-4915-bfe1-dfffc7ee3b33" --encryption-algorithm "RSAES_OAEP_SHA_256" --plaintext $PLAINTEXT | jq -c -r .CiphertextBlob)
echo $BLOB

aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms decrypt --key-id "5849c6ab-aace-4915-bfe1-dfffc7ee3b33" --encryption-algorithm "RSAES_OAEP_SHA_256" --ciphertext-blob $BLOB | jq -r -c '.Plaintext | @base64d'
```

## Resources

* https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/index.html
* https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/encrypt.html