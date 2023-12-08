# SECRETS MANAGER

Demonstrate some basics with secrets manager.  

## Background

AWS Secrets Manager is a service provided by Amazon Web Services (AWS) designed to help you protect access to your applications, services, and IT resources without the upfront investment and on-going maintenance costs of operating your own infrastructure. The key features and functions of AWS Secrets Manager include:  

* Secrets Management: It enables you to easily rotate, manage, and retrieve database credentials, API keys, and other secrets throughout their lifecycle.  

* Secure and Auditable Secret Storage: Secrets are stored securely with encryption. You can also integrate with AWS CloudTrail to audit secret usage.  

* Automatic Rotation of Secrets: Secrets Manager can automatically rotate secrets on a defined schedule. This feature supports AWS managed services such as RDS, and it can be configured for other secrets.  

* Fine-grained Access Control: You can control access to secrets using AWS Identity and Access Management (IAM) policies, ensuring that only authorized users and applications can access certain secrets.  

* Integration with Other AWS Services: Secrets Manager is designed to work with many AWS services, allowing you to retrieve secrets from within AWS Lambda functions, EC2 instances, RDS database instances, and more.  

* Cross-Region Replication: You can replicate secrets in Secrets Manager to multiple AWS regions to support high-availability and disaster recovery scenarios.  

* Centralized Management: It provides a central place to manage all your secrets, helping you replace hardcoded credentials in your code (including passwords) with an API call to Secrets Manager.  

Using AWS Secrets Manager helps in reducing the risks associated with managing credentials and secrets manually, and it plays a crucial role in meeting compliance requirements for handling sensitive data.  

NOTES:

* Secrets Manager does not immediately delete secrets. Instead, Secrets Manager immediately makes the secrets inaccessible and scheduled for deletion after a recovery window of a minimum of seven days.  
* Secrets are versioned.  
* It's possible to restore deleted secrets.  

TODO:

* Generating certificates.

## Listing

```sh
# list secrets
aws --no-cli-pager secretsmanager list-secrets | jq -c '.SecretList[] | {"Name":.Name, "ARN":.ARN}'

# including the secrets planned for deletion
aws --no-cli-pager secretsmanager list-secrets --include-planned-deletion | jq -c '.SecretList[] | {"Name":.Name, "ARN":.ARN}'
```

## Viewing

```sh
# show secret details
aws --no-cli-pager secretsmanager describe-secret --secret-id "arn:aws:secretsmanager:us-east-1:0000000000000:secret:ecr-pullthroughcache/dockerpullsecret-test" | jq . 

# get the secret value (can use name or arn)
aws --no-cli-pager secretsmanager get-secret-value --secret-id "ecr-pullthroughcache/dockerpullsecret-test" | jq .
```

## Creating

```sh
# remove old secret
aws --no-cli-pager secretsmanager delete-secret --secret-id ecr-pullthroughcache/dockerpullsecret-test

aws --no-cli-pager secretsmanager create-secret --name ecr-pullthroughcache/dockerpullsecret-test --secret-string '{"username":"myuser","accessToken":"mypass"}'
aws --no-cli-pager secretsmanager describe-secret --secret-id ecr-pullthroughcache/dockerpullsecret-test | jq .

# get the secret value
aws --no-cli-pager secretsmanager get-secret-value --secret-id "ecr-pullthroughcache/dockerpullsecret-test" | jq .
```

## Modifying

```sh
# modify secret
aws --no-cli-pager secretsmanager put-secret-value --secret-id ecr-pullthroughcache/dockerpullsecret-test --secret-string '{"username":"newuser","accessToken":"newpass"}'


aws --no-cli-pager secretsmanager get-secret-value --secret-id "ecr-pullthroughcache/dockerpullsecret-test" | jq .
```

## Resources

* Delete an Amazon Secrets Manager secret [here](https://docs.amazonaws.cn/en_us/secretsmanager/latest/userguide/manage_delete-secret.html)