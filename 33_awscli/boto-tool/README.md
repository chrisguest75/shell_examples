# BOTO TOOL

Used for performing actions that are not available in the AWS CLI.  

REF: [python_examples/07_aws_boto](https://github.com/chrisguest75/python_examples/blob/main/07_aws_boto/README.md)  

Demonstrates:

* signed PUT urls

## Start

```sh
# install
pyenv install

pipenv run lint
pipenv run test

pipenv shell

pipenv run start
```

## Usage

```sh
BUCKET_NAME=mybucket
# generate signed put urls 
SIGNEDURL1=$(pipenv run start --signed --bucket ${BUCKET_NAME} --prefix random5.bin | jq -r -s '.[].url' | grep https --color=no)
echo $SIGNEDURL1

# upload file
curl -v -X PUT -T "../out/random.bin" -H "Content-Type: application/octet-stream" $SIGNEDURL1

# list files
AWS_PROFILE=myprofile aws s3 ls ${BUCKET_NAME}
```

## Resources

