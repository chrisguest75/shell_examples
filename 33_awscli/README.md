# README

Demonstrates using awscli to query resources in an AWS account.

Powershell examples can be found [here](https://github.com/chrisguest75/powershell_examples)

TODO:

* pulling cloud watch metrics.  
* Sorting by columns  
* Create a docker container with awscli testbed inside of it.

```sh
# turn off the pager (NOTE: if you need help to work then it needs to be unset as this errors awscli)
export AWS_PAGER=   

# helpful gui for finding parameters
export AWS_CLI_AUTO_PROMPT=on-partial
# then use aws
aws 
# or 
aws --cli-auto-prompt           
```

## Environment

A lot of the examples are using `AWS_PROFILE` and `AWS_REGION`.  

```sh
cp ./.env.template ./.env
cat ./.env
nano ./.env
. ./.env     
```

```sh
# list available profiles
aws configure list-profiles   

# quick test
aws --profile [profile] s3 ls
```

## Troubleshooting

```sh
# add --debug flag
aws --profile [profile] --debug s3 ls
```

## Sts

You can use `STS` to work out your assumed role when trying to debug why you might be getting an Access Denied style issue.  

```sh
aws sts get-caller-identity
```

## ECR

Elastic Container Registry [ECR.md](./ECR.md)  

## S3

S3 [S3.md](./S3.md)  

## EC2

Elastic Compute [EC2.md](./EC2.md)  

## ECS

Elastic Container Services [ECS.md](./ECS.md)  

## Batch

AWS Batch [BATCH.md](./BATCH.md)  

## VPC

VPC [VPC.md](./VPC.md)  

## SSM

SSM [SSM.md](./SSM.md)  

## Route53

Route 53 [Route53.md](./ROUTE_53.md)  

## Lambda

Lambda [LAMBDA.md](./LAMBDA.md)  

## API Gateway

API Gateway [APIGATEWAY.md](./APIGATEWAY.md)  

## Cloud Formation

Cloud Formation [CLOUD_FORMATION.md](./CLOUD_FORMATION.md)  

## Resources

* AWS CLI with jq and Bash [here](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)  
* AWS-cli [here](https://docs.aws.amazon.com/cli/latest/userguide/aws-cli.pdf)  
* Filtering AWS CLI output [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html)  
* Troubleshooting AWS CLI errors [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-troubleshooting.html)  
