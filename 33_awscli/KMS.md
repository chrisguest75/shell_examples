# KEY MANAGEMENT SERVICE

Demonstrate how to work with KMS.  

NOTES:

* KMS has the concept of regional and multi regional keys
* Keys can only be deleted after being deactivated and a grace period expires. This can only be a minimum of 7 days.


```sh
export PAGER=          
export AWS_PROFILE=
export AWS_REGION=

# list keys (this doesn't return aliases/names)
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms list-keys | jq .

# describe a particular key (this will not return aliases either)
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms describe-key --key-id "449A7AB4-6FFE-4AF5-845D-7E9A8E933713" | jq .

# get the aliases
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms list-aliases | jq .

# find a key arn by alias.
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms describe-key --key-id "$(aws kms list-aliases | jq -r '.[][] | select(.AliasName == "alias/sops").TargetKeyId')" | jq -r '.KeyMetadata.Arn'
```

## Creation

```sh
# this type of SYMMETRIC_DEFAULT key can be used with SOPS.  Default is single region. 
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms create-key --key-usage ENCRYPT_DECRYPT --description "A key to be used by SOPS"

aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms create-key --key-usage ENCRYPT_DECRYPT --description "Test" --key-spec "RSA_4096"

# name has to start with "alias/"
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms create-alias --alias-name alias/mytestkey --target-key-id 5849c6ab-aace-4915-bfe1-dfffc7ee3b33
```

## Policies

```sh
# the policy is stored in a field.
aws kms get-key-policy --policy-name default --key-id "5849c6ab-aace-4915-bfe1-dfffc7ee3b33" | jq .
```

## Encrypt and Decrypt

```sh
PLAINTEXT=$(echo "hello world" | base64 )
BLOB=$(aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms encrypt --key-id "5849c6ab-aace-4915-bfe1-dfffc7ee3b33" --encryption-algorithm "RSAES_OAEP_SHA_256" --plaintext $PLAINTEXT | jq -c -r .CiphertextBlob)
echo $BLOB

aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms decrypt --key-id "5849c6ab-aace-4915-bfe1-dfffc7ee3b33" --encryption-algorithm "RSAES_OAEP_SHA_256" --ciphertext-blob $BLOB | jq -r -c '.Plaintext | @base64d'
```

## Remove Key

```sh
# remove an alias
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms delete-alias --alias-name alias/sops | jq .

# disable the key
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms disable-key --key-id cdb9cf8c-d7f7-4263-9ad5-7da2d8a20b75 | jq .

# schedule the key removal (minimum 7 days)
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" kms schedule-key-deletion --key-id cdb9cf8c-d7f7-4263-9ad5-7da2d8a20b75 --pending-window-in-days 7 | jq .
```

## Resources

* AWSCLI kms [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/index.html)  
* AWSCLI encrypt [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/encrypt.html)  
* ABAC for AWS KMS - Attribute-based access control (ABAC) [here](https://docs.aws.amazon.com/kms/latest/developerguide/abac.html)  
