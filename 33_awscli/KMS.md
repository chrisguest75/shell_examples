# KEY MANAGEMENT SERVICE

Demonstrate how to work with KMS.  

```sh
# list keys
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms list-keys | jq .

# describe a particular key
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms describe-key --key-id "449A7AB4-6FFE-4AF5-845D-7E9A8E933713" | jq .
```

## Encrypt and Decrypt

```sh
PLAINTEXT=$(echo "hello world" | base64 )
BLOB=$(aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms encrypt --key-id "5193dd66-2a4f-464e-a01c-d67fb1e64e1d" --encryption-algorithm "RSAES_OAEP_SHA_256" --plaintext $PLAINTEXT | jq -c -r .CiphertextBlob)
echo $BLOB

aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms decrypt --key-id "5193dd66-2a4f-464e-a01c-d67fb1e64e1d" --encryption-algorithm "RSAES_OAEP_SHA_256" --ciphertext-blob $BLOB | jq -r -c '.Plaintext | @base64d'
```

## Resources

* https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/index.html
* https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/encrypt.html