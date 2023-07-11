# Cloud Formation

Demonstrate some example commands for managing Cloud Formation Stacks

## List stacks

```sh
export PAGER=

# list all stacks in a region
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation list-stacks
```

## Get Cloud Formation outputs

```sh
export stackname=python-lambda-s3-get-dev
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks | jq -r ".Stacks[] | select(.StackName == \"$stackname\")"

# extract an output value
export stackname=python-lambda-s3-get-dev
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks | jq -r ".Stacks[] | select(.StackName == \"$stackname\").Outputs | .[] | select(.OutputKey == \"ServiceEndpoint\").OutputValue" 

# Get values
aws cloudformation describe-stacks --stack-name mylambdastack  --query "Stacks[0].Outputs" | jq -c '.[] | [.OutputKey, .OutputValue]'
```

## Resources

* cloudformation [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/index.html)
