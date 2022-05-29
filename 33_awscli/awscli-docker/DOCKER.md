# README

Create a container containing AWS CLI and share credentials into it.  

## Build

```sh
# build the image
docker build --no-cache --progress=plain -t awscli . 
```

## Run

```sh
# run a command 
docker run --rm -it -v$(realpath ~/.aws):/root/.aws -e AWS_PROFILE=$AWS_PROFILE -e AWS_REGION=$AWS_REGION awscli s3 ls
```

