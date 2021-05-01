# README
Demonstrates using awscli to query resources in an AWS account.

TODO:
* Sorting by columns

```sh
export AWS_PAGER=   
```

# S3
```sh
# list buckets in the account
aws s3 ls
aws s3api list-buckets | jq '.["Buckets"][].Name' --raw-output 
aws s3api list-buckets | jq '.["Buckets"][].Name' --raw-output | while read in; do aws s3api get-bucket-tagging --bucket $in; done

## Copy files to a subfolder
aws s3 cp "s3://file.json" "s3://folder/subfolder/ignition_etcd_0.json"
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

## Machine launched after a date

```sh
aws ec2 describe-instances --query 'Reservations[].Instances[?LaunchTime>=`2020-10-07`][].{id: InstanceId, type: InstanceType, launched: LaunchTime, ip_address: PrivateIpAddress, state: State.Name, imageid: ImageId}' --output table 
```

## Grouping instances by type

```sh
aws ec2 describe-instances | jq -r "[[.Reservations[].Instances[]|{ state: .State.Name, type: .InstanceType }]|group_by(.state)|.[]|{state: .[0].state, types: [.[].type]|[group_by(.)|.[]|{type: .[0], count: ([.[]]|length)}] }]"
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

# decode userdata
aws autoscaling describe-launch-configurations --query "LaunchConfigurations[*].{name: LaunchConfigurationName, imageid: ImageId, created: CreatedTime, userdata: UserData}" | jq '.[] | { name: .name, userdata: (.userdata | @base64d) }' | jq '. | select(.name=="mylaunchconfiguration")'

# export raw userdata
aws autoscaling describe-launch-configurations --query "LaunchConfigurations[*].{name: LaunchConfigurationName, imageid: ImageId, created: CreatedTime, userdata: UserData}" | jq '.[] | { name: .name, userdata: (.userdata | @base64d) }' | jq -r '. | select(.name=="mylaunchconfiguration") | .name, .userdata'
```

# Images

```sh
# images sorted by created date.
aws ec2 describe-images --owners self --query 'reverse(sort_by(Images,&CreationDate))[:5].{id:ImageId,date:CreationDate, name:Name}' --output table  
```


# Sts

```sh
aws sts get-caller-identity
```
# Resources
[aws-cli-with-jq](https://medium.com/circuitpeople/aws-cli-with-jq-and-bash-9d54e2eabaf1)  
[aws-cli.pdf](https://docs.aws.amazon.com/cli/latest/userguide/aws-cli.pdf)  
