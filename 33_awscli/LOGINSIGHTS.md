# LOGINSIGHTS

Demonstrate how to use `loginsights` from the cli.  

## Configure

```sh
export PAGER=
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-1
```

## Looking for strings in log groups

```sh
# find the loggroups
aws logs describe-log-groups | jq -r '.[][] | .logGroupName' 

LOGGROUP=myloggroup

# over two weeks (end time is required)
QUERYID=$(aws logs start-query --log-group-name ${LOGGROUP} --start-time $(date -v-14d '+%s') --end-time $(date '+%s') --query-string "fields @timestamp, @message, @logStream, @log | filter @message like /EAI_AGAIN/ | sort @timestamp desc" | jq -r .queryId)

# start from a specfic date and time
QUERYID=$(aws logs start-query --log-group-name ${LOGGROUP} --start-time $(date -d "2023-12-14 12:00:00" +"%s") --end-time $(date '+%s') --query-string "fields @timestamp, @message, @logStream, @log | filter @message like /EAI_AGAIN/ | sort @timestamp desc" | jq -r .queryId)

# use id to get logs 
aws logs get-query-results --query-id $QUERYID | jq .

# extract timestamps
aws logs get-query-results --query-id $QUERYID | jq '.results[][] | select(.field == "@timestamp") | (.value)'
```

## Simple Query for a container

```sh
aws ecs list-clusters  
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-tasks --cluster "clusterARN"

# configure the ECS cluster name (only name required not full ARN)
CLUSTERNAME=mycluster

# provide a taskid 
TASKID=01f512704d2b42658e4d389928b375f6

# start the query to list logs for a 
QUERYID=$(aws logs start-query --log-group-name /aws/ecs/containerinsights/$CLUSTERNAME/performance --start-time $(date -v-1d '+%s')   --end-time $(date '+%s') --query-string "fields @timestamp, @message, @logStream, @log | filter Type='Container' and TaskId='$TASKID' | sort @timestamp desc | limit 20" | jq -r .queryId)

# get the logs
aws logs get-query-results --query-id $QUERYID | jq .

# list queries for a cluster loggroup
aws logs describe-queries --log-group-name /aws/ecs/containerinsights/$CLUSTERNAME/performance
```

## Resources

* CloudWatch Logs Insights query syntax [here](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)  
* Supported logs and discovered fields [here](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData-discoverable-fields.html)
* Diving into Amazon ECS task history with Container Insights [here](https://nathanpeck.com/diving-into-amazon-ecs-task-history-with-container-insights/)  
