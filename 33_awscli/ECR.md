# Elastic Container Registry

TODO:
* List images
* Pull image locally and push an image.

```sh
aws ecr describe-repositories --region eu-west-1
```
aws ecr describe-images --repository-name cis-test --region eu-west-1
aws ecr describe-images --repository-name lambda_container_python --region eu-west-1


 aws ecr create-repository --repository-name apprunner-test --region eu-west-1

docker tag nginx:1.20.1 xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin "xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com"

docker push xxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/apprunner-test:nginx-1-20-1


