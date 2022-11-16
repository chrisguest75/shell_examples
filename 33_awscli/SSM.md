# SSM

Demonstrate how to use the `awscli` with SSM  

## Examples

```sh
# find a value
aws --profile my-profile --region eu-west-1 ssm describe-parameters | grep my-value

# show values
aws --profile my-profile --region eu-west-1 ssm get-parameter --name "/my-service/my-module/my-value"

# set a value
aws --profile my-profile --region us-east-1 ssm put-parameter --name "/my-service/my-module/my-value" --value 6 --overwrite
```
