# API Gateway

Demonstrate some example commands for managing AWS Lambda services

Amazon API Gateway is a fully managed service that makes it easy for developers to create, publish, and manage APIs (Application Programming Interfaces) for their applications. API Gateway handles all of the tasks involved in accepting and processing API requests, including traffic management, authorization and access control, monitoring, and API version management.  

Amazon API Gateway v2 is the latest version of the service, which provides additional features and enhancements over the previous version (API Gateway).  

The main differences between API Gateway and API Gateway v2 are:  

1) Protocols: API Gateway v2 supports both REST and WebSocket protocols, while API Gateway only supports REST.

2) Integration Types: API Gateway v2 supports a wider range of integration types, including Lambda, HTTP, AWS App Mesh, and others, while API Gateway only supports a limited set of integration types.

3) Routing: API Gateway v2 provides more flexible and sophisticated routing capabilities, including support for custom domain names and automatic generation of client SDKs, while API Gateway only provides basic routing features.

4) Security: API Gateway v2 provides improved security features, including support for OAuth 2.0 and JWT authorization, while API Gateway only provides basic security features.

Overall, API Gateway v2 provides more advanced and flexible features compared to API Gateway, but also requires a deeper understanding of the service to effectively utilize its capabilities.

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

## Custom domains

When you associate a custom domain with an Amazon API Gateway, it creates a new Amazon CloudFront distribution. This is because CloudFront is used to provide the custom domain mapping and SSL/TLS encryption for your API Gateway deployment.

Each CloudFront distribution is essentially a separate edge location network, so adding a custom domain creates a new "front door" for your API Gateway deployment. This allows you to serve your API traffic from multiple locations and enables you to customize the behavior and performance of your API deployment independently from other deployments.

For example, you could associate different custom domains with different stages of your API deployment, such as "prod.api.example.com" and "dev.api.example.com", and apply different caching and security settings to each domain. This helps you to manage your API deployment more effectively and provides better scalability, security, and reliability for your API consumers.

```sh
# get a list of custom domains
aws --profile "${AWS_PROFILE}" --region "${AWS_REGION}" apigateway get-domain-names | jq .
```

## Resources

* apigateway [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigateway/index.html)
* apigatewayv2 [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/apigatewayv2/index.html)
