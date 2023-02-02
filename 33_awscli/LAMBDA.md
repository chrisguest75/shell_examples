# Lambda

Demonstrate some example commands for managing AWS Lambda services

## Listing functions

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION lambda list-functions

# pull out function name
functionname=$(aws --profile $AWS_PROFILE --region $AWS_REGION lambda list-functions | jq -r ".Functions[0].FunctionName")
echo $functionname 

# list functions with runtimes
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" lambda list-functions | jq -r -c '.Functions[] | [.FunctionName, .Runtime]' | sort | jq -c .
```

## Invoke

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION lambda invoke --function-name ${functionname} --payload '{"text":"Hello"}' response.txt --cli-binary-format raw-in-base64-out 
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

## Destroy

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION lambda delete-function --function-name ${functionname}  
```

## Layers

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION list-layers | jq '.Layers[].LatestMatchingVersion.LayerVersionArn'

# publish
aws --profile $AWS_PROFILE --region $AWS_REGION lambda publish-layer-version --layer-name mylayer --zip-file fileb://./layer.zip | jq .
```

## Provisioned Concurrency

```sh
while IFS=, read -r FUNCTION_NAME
do
    aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" lambda list-provisioned-concurrency-configs --function-name "${FUNCTION_NAME}" | jq -r -c  --arg FUNCTION_NAME "${FUNCTION_NAME}" --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" '.ProvisionedConcurrencyConfigs[] | [$profile, $region, .RequestedProvisionedConcurrentExecutions, $FUNCTION_NAME]'
done < <(aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" lambda list-functions | jq -r -c '.Functions[].FunctionName') > ./provisionedconcurrency_${AWS_PROFILE}_${AWS_REGION}.json
```

## Reserved Concurrency


```sh
while IFS=, read -r FUNCTION_NAME
do
    aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" lambda get-function-concurrency --function-name "${FUNCTION_NAME}" | jq -r -c  --arg FUNCTION_NAME "${FUNCTION_NAME}" --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" '. | [$profile, $region, .ReservedConcurrentExecutions, $FUNCTION_NAME]'
done < <(aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" lambda list-functions | jq -r -c '.Functions[].FunctionName') > ./reservedconcurrency_${AWS_PROFILE}_${AWS_REGION}.json
```

## Resources

* Using Lambda with the AWS CLI [here](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-awscli.html)
* Lambda runtimes [here](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html)  
* Working with Lambda layers and extensions in container images [here](https://aws.amazon.com/blogs/compute/working-with-lambda-layers-and-extensions-in-container-images/)  
* list-provisioned-concurrency-configs [here](https://docs.aws.amazon.com/cli/latest/reference/lambda/list-provisioned-concurrency-configs.html)  
* get-function-concurrency [here](https://awscli.amazonaws.com/v2/documentation/api/2.4.18/reference/lambda/get-function-concurrency.html)  
* AWS Lambda Provisioned Concurrency: Build High-performance Serverless Applications at Scale [here](https://www.simform.com/blog/lambda-provisioned-concurrency)  
