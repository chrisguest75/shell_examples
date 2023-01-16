# ROLES

Demonstrate how to use roles.  

## Assuming Roles

Use the [awscli docker](./awscli-docker/DOCKER.md) example.  

```sh
export AWS_PROFILE=myprofile
export AWS_ACCESS_KEY=mykey
export AWS_ACCESS_KEY_SECRET=mysecret
export AWS_REGION=us-east-1
export PAGER=
aws configure set profile.$AWS_PROFILE.aws_access_key_id $AWS_ACCESS_KEY
aws configure set profile.$AWS_PROFILE.aws_secret_access_key $AWS_ACCESS_KEY_SECRET
aws s3 ls 

# assume role
export TARGET_ACCOUNT=000000000000
aws configure list
# in target account list roles
# aws iam list-roles --query "Roles[?RoleName == 'myrole'].[RoleName, Arn]"
aws sts assume-role --role-arn "arn:aws:iam::${TARGET_ACCOUNT}:role/myrole" --role-session-name AWSCLI-Session | jq . 

# NOTE: without quotes
export AWS_PROFILE=mynewprofile
export AWS_ACCESS_KEY=mykey
export AWS_ACCESS_KEY_SECRET=mysecret
export AWS_SESSION_TOKEN=mysessiontoken

aws configure set profile.$AWS_PROFILE.aws_access_key_id $AWS_ACCESS_KEY
aws configure set profile.$AWS_PROFILE.aws_secret_access_key $AWS_ACCESS_KEY_SECRET
aws configure set profile.$AWS_PROFILE.aws_session_token $AWS_SESSION_TOKEN

aws configure list

aws s3 ls 
```

## Resources

* How do I assume an IAM role using the AWS CLI? [here](https://aws.amazon.com/premiumsupport/knowledge-center/iam-assume-role-cli/)  
* How can I troubleshoot the AWS STS error “the security token included in the request is expired” when using the AWS CLI to assume an IAM role? [here](https://aws.amazon.com/premiumsupport/knowledge-center/sts-iam-token-expired/)  

