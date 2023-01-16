# README

Create a container containing AWS CLI and share credentials into it.  

## Build

```sh
# build the image
docker build --no-cache --progress=plain -t awscli . 
```

## Run (host profile)

```sh
# run a command 
docker run --rm -it -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION awscli s3 ls
```

## Run (configure internal profile)

```sh
# run a command 
docker run --rm -it --entrypoint /bin/bash awscli

export AWS_PROFILE=myprofile
export AWS_ACCESS_KEY=mykey
export AWS_ACCESS_KEY_SECRET=mysecret
export AWS_REGION=us-east-1
export PAGER=
aws configure set profile.$AWS_PROFILE.aws_access_key_id $AWS_ACCESS_KEY
aws configure set profile.$AWS_PROFILE.aws_secret_access_key $AWS_ACCESS_KEY_SECRET
aws s3 ls 
```

## Troubleshooting

```sh
# enter the container 
docker run --rm -it -v$(realpath ~/.aws):/root/.aws --entrypoint /bin/bash -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION awscli
```

## Resources

* AWS CLI Command Reference [here](https://docs.aws.amazon.com/cli/latest/index.html)
