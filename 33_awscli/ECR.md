# Elastic Container Registry

TODO:

* Calculate number of images.  
* Get tags
* Get policies etc. 

## Login

```sh
# to be able to pull images
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com"
```

## Listing

Listing respositories.  

```sh
export PAGER=
aws ecr describe-repositories --region eu-west-1
```

```sh
aws ecr describe-images --repository-name imagename --region eu-west-1
```

## Pushing

Pushing images to new repositories  

```sh
aws ecr create-repository --repository-name apprunner-test --region eu-west-1

docker tag nginx:1.20.1 xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com"

docker push xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1
```
