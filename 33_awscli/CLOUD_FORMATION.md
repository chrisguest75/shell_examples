# Cloud Formation

Demonstrate some example commands for managing Cloud Formation Stacks

## Get Cloud Formation outputs

```sh
export stackname=python-lambda-s3-get-dev
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks | jq -r ".Stacks[] | select(.StackName == \"$stackname\")"
```

## Resources

* cloudformation [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/index.html)
