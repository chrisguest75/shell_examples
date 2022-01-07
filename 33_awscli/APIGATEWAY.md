# API Gateway

Demonstrate some example commands for managing AWS Lambda services

## Get the apigateway details

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

NOTE: In Serverless Stack the url can be pulled from the CloudFormation output.  

```sh
# example of how to construct api url 
export stage=dev
export service=dev-python-lambda-s3-get
export apigatewayid=$(aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-rest-apis | jq -r ".items[] | select(.name == \"$service\").id")
echo "https://${apigatewayid}.execute-api.${AWS_REGION}.amazonaws.com/${stage}"
```

## Get the apigatewayv2 details

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION apigatewayv2 get-apis 
```

## Resources

* apigateway [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigateway/index.html)
* apigatewayv2 [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigatewayv2/index.html)
