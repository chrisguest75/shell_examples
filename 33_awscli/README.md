# README

Demonstrates using awscli to query resources in an AWS account.

Powershell examples can be found [here](https://github.com/chrisguest75/powershell_examples)

TODO:

* lambda and api gateway.  
* pulling cloud watch metrics.  
* Sorting by columns  

```sh
export AWS_PAGER=   
```

## ECR 

[ECR.md](./ECR.md)  

## S3

[S3.md](./S3.md)  

## EC2

[EC2.md](./EC2.md)  

## Batch

[BATCH.md](./BATCH.md)  

## VPC

[VPC.md](./VPC.md)  

## Route53

[Route53.md](./Route53.md)  


## Sts

You can use `STS` to work out your assumed role when trying to debug why you might be getting an Access Denied style issue.  

```sh
aws sts get-caller-identity
```

## Resources

* AWS CLI with jq and Bash [here](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)  
* AWS-cli [here](https://docs.aws.amazon.com/cli/latest/userguide/aws-cli.pdf)  
