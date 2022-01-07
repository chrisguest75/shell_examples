# Lambda

Demonstrate some example commands for managing AWS Lambda services

## Listing functions

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION lambda list-functions

# pull out function name
functionname=$(aws --profile $AWS_PROFILE --region $AWS_REGION lambda list-functions | jq -r ".Functions[0].FunctionName")
echo $functionname 
```

## Log streams

```sh
# sort the logStreams object and get top 5 objects
aws logs describe-log-streams --profile $AWS_PROFILE --region $AWS_REGION --log-group-name /aws/lambda/${functionname} --query 'reverse(sort_by(logStreams,&creationTime))[:5].{logStreamName:logStreamName,date:creationTime}' --output table  
```


## Log events

```sh
# use single quote to prevent substitution of $LATEST
aws --profile $AWS_PROFILE --region $AWS_REGION logs get-log-events --log-group-name "/aws/lambda/${functionname}" --log-stream-name '2022/01/07/[$LATEST]e573471430114176a11841482cfa66c1'
```

## Resources

* Using Lambda with the AWS CLI [here](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-awscli.html)
