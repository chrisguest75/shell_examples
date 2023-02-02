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

## Build URLs

NOTE: In Serverless Stack the url can be pulled from the CloudFormation output.  

```sh
# example of how to construct api url 
export stage=dev
export service=dev-python-lambda-s3-get
export apigatewayid=$(aws --profile $AWS_PROFILE --region $AWS_REGION apigateway get-rest-apis | jq -r ".items[] | select(.name == \"$service\").id")
echo "https://${apigatewayid}.execute-api.${AWS_REGION}.amazonaws.com/${stage}"

aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" apigateway get-rest-apis | jq -r -c '.items[] | ["https://\(.id).execute-api.'${AWS_REGION}'.amazonaws.com/\(.tags.STAGE)", .name]'
```

## Get the apigatewayv2 details

```sh
# gateway v2
aws --profile $AWS_PROFILE --region $AWS_REGION apigatewayv2 get-apis 

# endpoints and names
aws --profile $AWS_PROFILE --region $AWS_REGION apigatewayv2 get-apis | jq -r -c '.Items[] | [.ApiEndpoint, .Name]'
```

## Report on gateways

```sh
while IFS=, read -r AWS_PROFILE AWS_REGION
do
    aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" apigateway get-rest-apis | jq --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" -r -c '.items[] | ["v1", $profile, $region, "https://\(.id).execute-api.'${AWS_REGION}'.amazonaws.com/\(.tags.STAGE)", .name]'
    aws --profile $AWS_PROFILE --region $AWS_REGION apigatewayv2 get-apis | jq --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" -r -c '.Items[] | ["v2", $profile, $region, .ApiEndpoint, .Name]'
done << EOF > ./apigateways.json
profile1,us-east-1
profile1,eu-west-1
profile2,us-east-1
profile1,eu-west-1
profile3,us-east-1
profile3,eu-west-1
EOF
```

## Resources

* apigateway [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigateway/index.html)
* apigatewayv2 [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigatewayv2/index.html)
