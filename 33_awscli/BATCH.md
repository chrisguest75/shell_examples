# Batch

Demonstrate some example commands for managing AWS Batch services

NOTES ON BATCH:

* A queue only has 10000 entries

## 
```sh
aws --profile $AWS_PROFILE batch describe-compute-environments | jq
```
## Get the Queues

```sh
export AWS_PROFILE=

# get the job queues 
aws --profile $AWS_PROFILE --region eu-west-1 batch describe-job-queues | jq

# get the names of the queues
aws --profile $AWS_PROFILE --region eu-west-1 batch describe-job-queues | jq -r '.jobQueues[].jobQueueName'
```

## List jobs

List jobs by status in queues

```sh
aws --profile $AWS_PROFILE --region us-east-1 batch list-jobs --job-status FAILED --job-queue batch-queue-name

aws --profile $AWS_PROFILE --region us-east-1 batch list-jobs --job-status SUCCEEDED --job-queue batch-queue-name

# get the jobid only
aws --profile $AWS_PROFILE --region us-east-1 batch list-jobs --job-status FAILED --job-queue batch-queue-name | jq '.jobSummaryList[].jobId'
```

## Look at jobs

```sh
# use id from listed job
aws --profile $AWS_PROFILE --region us-east-1 batch describe-jobs --jobs ebf9e2f3-c055-46ef-b05e-27a6a06d44a6

# get logstreams
aws --profile $AWS_PROFILE --region us-east-1 batch describe-jobs --jobs "6226bf5f-3574-4613-aa13-31de0bd6201e" | jq '.jobs[].attempts[].container.logStreamName'
```

## Logs

```sh
# get the log groups
aws --profile $AWS_PROFILE --region us-east-1 logs describe-log-groups

# logstreams
aws --profile $AWS_PROFILE --region us-east-1 logs describe-log-streams --log-group-name "/aws/batch/job" --max-items 10

aws --profile $AWS_PROFILE --region us-east-1 logs describe-log-streams --log-group-name "/aws/batch/job" --log-stream-name-prefix "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3"
```

## Log Events

```sh
aws --profile $AWS_PROFILE --region us-east-1 logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3"

 aws --profile $AWS_PROFILE --region us-east-1 logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3" | jq -c '.events[].message'
```

## Filters

```sh
aws --profile $AWS_PROFILE --region us-east-1 batch list-jobs --job-queue batch-queue --job-status FAILED --filters "name=BEFORE_CREATED_AT,values=1640124949"
```

## Resources

* AWS Batch service quotas [here](https://docs.aws.amazon.com/batch/latest/userguide/service_limits.html)
* Boto3 Docs 1.20.26 documentation - Batch [here](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/batch.html)




