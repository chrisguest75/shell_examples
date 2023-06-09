# LOCATING RESOURCES

## Accounts

```sh
aws organizations list-accounts | jq . 

export AWS_REGION=us-east-1
export AWS_PROFILE=myprofile
```

## Get tags

```sh
# needs to be run on account with permission for billing
aws ce list-cost-allocation-tags | jq -r '.CostAllocationTags[].TagKey'
```

## Finding Resources with Tags

Using tags to find resources and then checking costs.  

```sh
# get tag names 
aws resourcegroupstaggingapi get-tag-values --key=ServiceGroup

# list resources with a tag and value
aws resourcegroupstaggingapi get-resources --tag-filters Key=ServiceGroup,Values=live-engine --query "ResourceTagMappingList[*].ResourceARN"

# THIS IS BROKEN ALWAYS 0 COST - get cost of an arn 
aws ce get-cost-and-usage-with-resources --time-period Start="2023-06-01",End="2023-06-08" --granularity DAILY --metrics BlendedCost --filter file://./cost-queries/resources_arn.json | fx
```

## Finding Resources on ECS

```sh
# list the clusters in the region
aws ecs list-clusters

# 
export MYCLUSTER=mycluster
aws ecs list-tasks --cluster $MYCLUSTER --query "taskArns[]"

# describe a task (tags are empty)
export MYTASK=mytask
aws ecs describe-tasks --cluster $MYCLUSTER --include TAGS --tasks $MYTASK

# but this returns tags
aws ecs list-tags-for-resource --resource-arn $MYTASK --query 'tags'

# list tasks on a cluster
aws ecs list-tasks --cluster $MYCLUSTER --query "taskArns[]" | jq -r '.[]' | xargs -L 1 aws ecs describe-tasks --cluster $MYCLUSTER --include TAGS --tasks | jq -c '.tasks[0] | [.group, .createdAt, .cpu, .memory, .tags]'

# THESE ARE NOT WORKING
date -v-24H -u +%Y-%m-%dT%H:%M:%S.%NZ
date -u -v-1d '+%Y-%m-%dT%H:%M:%S.%NZ'
aws ecs list-tasks --cluster $MYCLUSTER --query 'tasks[?createdAt<"2023-06-09"]'

aws ecs list-tasks --cluster $MYCLUSTER --query "taskArns[?contains(to_string(Tags), 'Key=mytag,Value=myvalue')]"

aws ecs list-tasks --cluster $MYCLUSTER --query "taskArns[?contains(Tags[?Key=='mytag'].Value, 'myvalue')]" --output text

aws ecs list-tasks --cluster $MYCLUSTER --query "taskArns[?Tags[?Key=='ServiceGroup'] && contains(Tags[?Key=='mytag'].Value, 'myvalue')]" --output text
```
