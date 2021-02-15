# README
Demonatrates using awscli to query resources in an AWS account.

TODO:
* Sorting by columns

```sh
export AWS_PAGER=   
```
# EC2 Instances
## Describe Instances
```sh
# filter out terminated instances
aws ec2 describe-instances  --query "Reservations[*].Instances[*].{name: Tags[?Key=='Name'] | [0].Value, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, imageid: ImageId}" --filters "Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped" --output table
```

## Multiple compound filters
```sh
# multiple filters need to be seperated by a space and not grouped with quotes
aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key=='Name'] | [0].Value, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, imageid: ImageId, launch: LaunchTime}" --filters Name=tag:Name,Values=k8s-eu-worker Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table 

aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key=='Name'] | [0].Value, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, imageid: ImageId, launch: LaunchTime}" --filters Name=tag:Name,Values=k8s-eu-master Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table 

# wildcards in filters
aws ec2 describe-instances --query "Reservations[*].Instances[*].{name: Tags[?Key=='Name'] | [0].Value, instance_id: InstanceId, ip_address: PrivateIpAddress, state: State.Name, imageid: ImageId, launch: LaunchTime}" --filters "Name=tag:Name,Values=k8s-eu-etcd-*" Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table 
```

## Terminate 
```sh
aws ec2 terminate-instances --instance-ids [id]
```

# Auto Scaling Groups 
## Describe ASG
```sh
# find the auto scaling groups
aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].{name: AutoScalingGroupName, minsize: MinSize, maxsize: MaxSize, desired: DesiredCapacity,launch_config: LaunchConfigurationName}" --output table 
```

```sh
# It is not possible to filter ASG api so we use jq
aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].{name: AutoScalingGroupName, minsize: MinSize, maxsize: MaxSize, desired: DesiredCapacity,launch_config: LaunchConfigurationName}" --output json | jq "(.[] | select(.name | contains(\"k8s-eu-workers\")) | {name, launch_config, desired})" 
```

## Increase ASG desired 
```sh
# Add an extra node to the ASG
aws autoscaling update-auto-scaling-group --auto-scaling-group-name k8s-eu-worker-20210212093419459600000001 --desired-capacity=12
```

# Launch Configurations
## Describe Launch Configurations 
```sh
# describe launch configurations
aws autoscaling describe-launch-configurations --query "LaunchConfigurations[*].{name: LaunchConfigurationName, imageid: ImageId, created: CreatedTime}" --output table 
```





aws ec2 describe-instances --query 'Reservations[].Instances[?LaunchTime>=`2020-10-07`][].{id: InstanceId, type: InstanceType, launched: LaunchTime}'


aws s3api list-buckets | jq '.["Buckets"][].Name' --raw-output 
aws s3api list-buckets | jq '.["Buckets"][].Name' --raw-output | while read in; do aws s3api get-bucket-tagging --bucket $in; done