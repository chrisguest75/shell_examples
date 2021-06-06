# VPC


```sh
# get vpcs in region
aws ec2 describe-vpcs --region eu-west-1    
# print out available addresses in the subnet       
aws ec2 describe-subnets --region eu-west-1 --filters Name=vpc-id,Values=vpc-0b810718ab2ddbefb | jq '.Subnets[].AvailableIpAddressCount'         
```