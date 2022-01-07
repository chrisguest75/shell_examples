# API Gateway

Demonstrate some example commands for managing AWS Lambda services

## Get the gateway details

```sh
# get the rest-api details (including tags)
aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-rest-apis

# get deployments for an api
aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-deployments --rest-api-id nfqm9s0qf6

# get stages for an api
aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-stages --rest-api-id nfqm9s0qf6

aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-resources --rest-api-id nfqm9s0qf6
```

## Build URL

```sh
# example of how to construct api url 
export stage=dev
export service=dev-python-lambda-s3-get
export apigatewayid=$(aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-rest-apis | jq -r ".items[] | select(.name == \"$service\").id")
echo "https://${apigatewayid}.execute-api.${AWS_REGION}.amazonaws.com/${stage}"
```



```sh
aws --profile $AWS_PROFILE --region $AWS_REGION apigatewayv2 get-apis 
```


## Resources

* apigateway https://docs.aws.amazon.com/cli/latest/reference/apigateway/index.html#cli-aws-apigateway

* apigatewayv2 https://docs.aws.amazon.com/cli/latest/reference/apigatewayv2/index.html