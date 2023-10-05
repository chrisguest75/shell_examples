# Cloud Formation

Demonstrate some example commands for managing Cloud Formation Stacks

## List stacks

Find and list the deployed stacks.  

```sh
export PAGER=

# list all stacks in a region
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation list-stacks

# grab stack older than a date that are still deployed
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation list-stacks --query "StackSummaries[?LastUpdatedTime<='2023-02-01'&&StackStatus=='UPDATE_COMPLETE']" | jq '. |= sort_by(.LastUpdatedTime) | .'

# describe
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks --query "Stacks[?LastUpdatedTime<='2023-02-01'&&StackStatus=='UPDATE_COMPLETE']" | jq '. |= sort_by(.LastUpdatedTime) | .'
```

## Get Cloud Formation outputs

Get outputs from stacks so you can pass them into other processess.  

```sh
export stackname=python-lambda-s3-get-dev
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks | jq -r ".Stacks[] | select(.StackName == \"$stackname\")"

# extract an output value
export stackname=python-lambda-s3-get-dev
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks | jq -r ".Stacks[] | select(.StackName == \"$stackname\").Outputs | .[] | select(.OutputKey == \"ServiceEndpoint\").OutputValue" 

# Get values
aws cloudformation describe-stacks --stack-name mylambdastack  --query "Stacks[0].Outputs" | jq -c '.[] | [.OutputKey, .OutputValue]'
```

## List stack resources

Get a list of the resources in a stack.  

```sh
# get the first stack name
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stacks --query "Stacks[?LastUpdatedTime<='2023-02-01'&&StackStatus=='UPDATE_COMPLETE']" | jq -r '. |= sort_by(.LastUpdatedTime) | .[0].StackName'

# show resources
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stack-resources --stack-name "mystackname"
```

## Delete stacks

NOTE: Deleting stacks with non-empty buckets will fail.  

```sh
# find stacks to delete.
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation list-stacks --query "StackSummaries[?LastUpdatedTime<='2023-08-01'&&StackStatus=='UPDATE_COMPLETE']" | jq '. |= sort_by(.LastUpdatedTime) | .' | jq '.[].StackName' | sort

# show resource types
export STACKNAME=
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stack-resources --stack-name "$STACKNAME" | jq -r '.StackResources[] | [.ResourceType, .PhysicalResourceId] | @csv' | sort
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation describe-stack-resources --stack-name "$STACKNAME" | jq -r '.StackResources[] | [.ResourceType, .PhysicalResourceId] | @csv' | grep "AWS::S3::Bucket"

export BUCKETNAME=
# get the bucket name from the resources
aws --profile $AWS_PROFILE --region $AWS_REGION s3 ls s3://${BUCKETNAME}
aws --profile $AWS_PROFILE --region $AWS_REGION s3 rm --recursive s3://${BUCKETNAME}

# now delete stack
aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation delete-stack --stack-name "$STACKNAME"
```

## Resources

* cloudformation [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/index.html)
