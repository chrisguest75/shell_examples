# Batch

Demonstrate some example commands for managing AWS Batch services  

- [Batch](#batch)
  - [Background](#background)
  - [Compute Environments](#compute-environments)
  - [Get the Queues](#get-the-queues)
  - [List jobs](#list-jobs)
  - [Investigate jobs](#investigate-jobs)
  - [Logs](#logs)
  - [Log Events](#log-events)
  - [Filters](#filters)
  - [Resources](#resources)

TODO:

* Work out if container insights is installed.
* Work out logs can be despatched.
* How do I know they are on fargate?  

## Background

AWS Batch is a service provided by Amazon Web Services (AWS) designed to efficiently run batch computing jobs in the cloud. It simplifies the process of running these jobs, which typically involve executing a series of tasks or a workload that can be processed in parallel without user interaction. Here's an overview of how AWS Batch works:  

* Job Definition: This is the first step in using AWS Batch. A job definition specifies how jobs are to be run. It includes details like which Docker container image to use, memory and CPU requirements, and environment variables.  

* Job Queue: After defining a job, you submit it to a job queue. The job queue stores jobs until they can be scheduled to run on compute resources. You can have multiple job queues for different priority levels or types of jobs.  

* Compute Environments: AWS Batch runs jobs in a compute environment. This is a set of EC2 instances or AWS Fargate resources that you define based on your specific requirements. You can have different compute environments for different types of jobs or workloads.  

* Scheduling and Execution: AWS Batch has a scheduler that evaluates the job queues and dispatches jobs to available compute resources based on their priority and resource requirements. The scheduler attempts to efficiently use resources to reduce costs and maximize throughput.  

* Scaling: AWS Batch can automatically scale your compute resources up or down based on the workload. This is done by integrating with AWS's Auto Scaling groups. This means if there are a lot of jobs in the queue, AWS Batch can add more EC2 instances to your compute environment, and it can scale down when the job queue is empty.  

* Monitoring and Logging: AWS Batch integrates with other AWS services like CloudWatch for monitoring and logging. This allows you to track the status of your jobs, view logs, and get alerts based on specific metrics or events.  

* Integration with Other AWS Services: AWS Batch can be integrated with other AWS services like AWS Lambda, Amazon S3, Amazon RDS, and Amazon DynamoDB. This allows for a more comprehensive and interconnected cloud solution.  

AWS Batch is especially useful for workloads that are not time-sensitive and can be processed asynchronously, such as data processing, image processing, financial modeling, and scientific simulations. It handles the provisioning, management, and scaling of the compute infrastructure, which simplifies running batch jobs at scale.  

NOTES:

* A queue only has 10000 entries
* You can attach multiple compute environments to queues.  

## Compute Environments

List the compute environments.  

```sh
export AWS_PROFILE=
export AWS_REGION=

aws --profile $AWS_PROFILE --region $AWS_REGION batch describe-compute-environments | jq
```

## Get the Queues

Queues are attached to compute environments.  

```sh
# get the job queues 
aws --profile $AWS_PROFILE --region $AWS_REGION batch describe-job-queues | jq

# get the names of the queues
aws --profile $AWS_PROFILE --region $AWS_REGION batch describe-job-queues | jq -r '.jobQueues[].jobQueueName'
```

## List jobs

* Job Scheduling: After a job is submitted, it first enters the SUBMITTED state and then moves to the PENDING state. In the PENDING state, AWS Batch is preparing to schedule the job based on the compute resources availability and other scheduling constraints.

* Transition to RUNNABLE: Once the job is ready to be scheduled, it moves to the RUNNABLE state. Here, it waits for the necessary compute resources (like a vCPU and memory) to become available in one of the compute environments associated with the job's queue.

* Resource Allocation: When resources are available, AWS Batch allocates these resources to the job. At this point, the job is still in the RUNNABLE state.

* Container Image Pulling: Before the job moves to the STARTING or RUNNING state, AWS Batch needs to pull the container image specified in the job definition. This image pull time is included in the queue time. If the image is not already present on the chosen compute resource, this step can take a significant amount of time, especially for larger images or in cases where network bandwidth is limited.

* Job Execution: After the image is pulled and the container is set up, the job transitions to the STARTING and then to the RUNNING state, where it begins executing the workload.

List jobs by status in queues  

Status - SUBMITTED | PENDING | RUNNABLE | STARTING | RUNNING | SUCCEEDED | FAILED  

```sh
# get failed
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-status FAILED --job-queue batch-queue-name

# get the jobid only
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-status FAILED --job-queue batch-queue-name | jq '.jobSummaryList[].jobId'

# get number of RUNNING jobs in queue
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-status RUNNING --job-queue batch-queue-name | jq -r ".jobSummaryList | length"

# find jobs names starting with a prefix (also show jobtime, totaltime and queuetime)  
# NOTE: Use filters below for performance
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-status SUCCEEDED --job-queue batch-queue-name  | jq -r -c '.jobSummaryList[] | select(.jobName | startswith("jobprefix")) | [.jobName, (((.stoppedAt - .startedAt)/1000) | "\(.) seconds"), (((.startedAt - .createdAt)/1000) | "\(.) seconds"), (((.stoppedAt - .createdAt)/1000) | "\(.) seconds"), .jobId]'

# get date and time of failed jobs. 
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-queue batch-queue-name --job-status FAILED | jq "(.jobSummaryList[].startedAt/1000 | floor)" | xargs -I {} gdate --date=@{}

# parse job failed data 
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-queue cbatch-queue-name --job-status FAILED | jq ".jobSummaryList[] | { startedAt: (.startedAt/1000 | floor), status:.status, jobname:.jobName, jobid: .jobId, reason: .container.reason}"
```

## Investigate jobs

```sh
# use id from listed job
aws --profile $AWS_PROFILE --region $AWS_REGION batch describe-jobs --jobs ebf9e2f3-c055-46ef-b05e-27a6a06d44a6

# get logstreams
aws --profile $AWS_PROFILE --region $AWS_REGION batch describe-jobs --jobs "6226bf5f-3574-4613-aa13-31de0bd6201e" | jq '.jobs[].attempts[].container.logStreamName'
```

## Logs

```sh
# get the log groups
aws --profile $AWS_PROFILE --region $AWS_REGION logs describe-log-groups

# logstreams
aws --profile $AWS_PROFILE --region $AWS_REGION logs describe-log-streams --log-group-name "/aws/batch/job" --max-items 10

aws --profile $AWS_PROFILE --region $AWS_REGION logs describe-log-streams --log-group-name "/aws/batch/job" --log-stream-name-prefix "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3"
```

## Log Events

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3"

aws --profile $AWS_PROFILE --region $AWS_REGION logs get-log-events --log-group-name "/aws/batch/job" --log-stream-name "batch-queue/default/0a5cb67be7ca4396b21f8784e68255f3" | jq -c '.events[].message'
```

## Filters

Use filters for performance with large queues.  

```sh
# this will also filter by prefix 
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-queue jobqueue --filters "name=JOB_NAME,values=5c4734c69a8608bfaa3ca94c*"  | jq -r -c '.jobSummaryList[] | select(.jobName | startswith("jobprefix")) | [.jobName, (((.stoppedAt - .startedAt)/1000) | "\(.) seconds"), (((.startedAt - .createdAt)/1000) | "\(.) seconds"), (((.stoppedAt - .createdAt)/1000) | "\(.) seconds"), .jobId]'

# or before a specific date
aws --profile $AWS_PROFILE --region $AWS_REGION batch list-jobs --job-queue batch-queue --job-status FAILED --filters "name=BEFORE_CREATED_AT,values=1640124949"
```

## Resources

* AWS Batch service quotas [here](https://docs.aws.amazon.com/batch/latest/userguide/service_limits.html)
* Boto3 Docs 1.20.26 documentation - Batch [here](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/batch.html)
* AWS Batch Runtime Monitoring Dashboards Solution [here](https://github.com/aws-samples/aws-batch-runtime-monitoring)  
* Optimizing your AWS Batch architecture for scale with observability dashboards [here](https://aws.amazon.com/blogs/hpc/optimizing-aws-batch-with-observability-dashboards/)
