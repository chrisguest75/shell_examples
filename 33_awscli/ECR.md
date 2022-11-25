# Elastic Container Registry

TODO:

* Calculate number of images.  
* Get tags
* Get policies etc.

## Login

```sh
# to be able to pull images locally
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com"
```

## Listing

Listing registries and respositories.  

A `registry` contains `repositiories` and `repositories` contain images.  

```sh
export PAGER=

# describe any parameters on the registry
aws ecr describe-registry --profile my-profile 
```

```sh
# list all the repositories
aws ecr describe-repositories --region eu-west-1
```

```sh
# image name without registry name
aws ecr describe-images --repository-name imagename --region eu-west-1
```

## Pushing

Pushing images to new repositories  

```sh
# create a new repository
REPOSITORY_URL=$(aws ecr create-repository --repository-name apprunner-test --region eu-west-1 | jq .repository.repositoryUri)
echo $REPOSITORY_URL

# registry/imagename:tag
docker tag nginx:1.20.1 xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1

# login so we can push
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com"

# push image
docker push xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1

# delete the repository
aws ecr delete-repository --repository-name apprunner-test --region eu-west-1 | jq -r .repository.repositoryUri
```

## Resources

* AWS CLI ECR [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecr/index.html)  
