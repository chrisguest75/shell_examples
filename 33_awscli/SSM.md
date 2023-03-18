# SSM

Demonstrate how to use the `awscli` with SSM  

## Examples

TODO:

* Pull metrics from cloudwatch about utilisation.  

### Parameter Store

AWS Systems Manager Parameter Store is a managed service that provides a centralized location to store and manage application configuration data, secrets, and other frequently used parameters. It securely stores parameters as key-value pairs and makes them available to authorized AWS resources and applications.  

SSM Parameter Store can be used to store various types of data, including plaintext and encrypted strings, JSON, and binary data. It supports parameter hierarchies, versioning, and permissions management, allowing you to manage and organize your parameters efficiently.  

Parameter Store can be accessed via the AWS Management Console, AWS CLI, AWS SDKs, or through API calls, making it easy to integrate with your existing tools and workflows. It can also be used with other AWS services such as AWS Lambda, EC2, and CloudFormation to automate and manage your infrastructure and applications.  

In summary, AWS SSM Parameter Store is a secure, scalable, and flexible service that simplifies the management and retrieval of application configuration and secrets in the AWS environment.  

```sh
# find a value
aws --profile my-profile --region eu-west-1 ssm describe-parameters | grep my-value

# show values
aws --profile my-profile --region eu-west-1 ssm get-parameter --name "/my-service/my-module/my-value"

# set a value
aws --profile my-profile --region us-east-1 ssm put-parameter --name "/my-service/my-module/my-value" --type String --value 6 --overwrite
```
