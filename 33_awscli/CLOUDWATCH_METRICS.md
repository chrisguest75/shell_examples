# Cloudwatch Metrics

Demonstrate some example commands for managing Cloudwatch Metrics.  

NOTE:

* list-metrics seems to take a long time
```sql
SELECT SUM(NumberOfMessagesSent) FROM SCHEMA("AWS/SQS", QueueName)  GROUP BY QueueName ORDER BY SUM() DESC LIMIT 10

# s3
SELECT AVG(TotalRequestLatency) FROM SCHEMA("AWS/S3", BucketName, FilterId) WHERE FilterId = 'EntireBucket' GROUP BY BucketName ORDER BY AVG() DESC
```

## Namespaces

Metrics have namespaces  

```txt
"AWS/ApiGateway"
"AWS/ApplicationELB"
"AWS/AutoScaling"
"AWS/Backup"
"AWS/Billing"
"AWS/CertificateManager"
"AWS/CloudFront"
"AWS/DynamoDB"
"AWS/EBS"
"AWS/EC2"
"AWS/ECR"
"AWS/ECS"
"AWS/ECS/ManagedScaling"
"AWS/EFS"
"AWS/ELB"
"AWS/ES"
"AWS/ElastiCache"
"AWS/Events"
"AWS/Firehose"
"AWS/Inspector"
"AWS/Lambda"
"AWS/Logs"
"AWS/NATGateway"
"AWS/NetworkELB"
"AWS/PrivateLinkEndpoints"
"AWS/Route53"
"AWS/S3"
"AWS/SNS"
"AWS/SQS"
"AWS/Schemas"
"AWS/SecretsManager"
"AWS/States"
"AWS/TransitGateway"
"AWS/Translate"
"AWS/Usage"
"AWS/WAFV2"
"AWS/X-Ray"
"ContainerInsights"
"ECS/ContainerInsights"
```

## Metrics

```sh
export AWS_PAGER=

aws cloudwatch list-metric-streams --max-results 10
aws cloudwatch list-metrics --max-items 10

# aggregate the metrics namespaces
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch list-metrics | jq '.Metrics[].Namespace' | sort | uniq


# list metrics names
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch list-metrics --namespace "AWS/EC2"

aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch list-metrics --namespace "AWS/S3"

aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch list-metrics --namespace "AWS/Lambda"
```

## S3

```sh
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch list-metrics --namespace "AWS/S3" --dimensions Name=BucketName,Value=${BUCKET_NAME}

## This is not working
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch get-metric-statistics --namespace "AWS/S3" --metric-name "NumberOfObjects" --dimensions Name=BucketName,Value=${BUCKET_NAME} Name=StorageType,Value=AllStorageTypes --start-time $(gdate -u -d "1 day ago" +"%Y-%m-%dT%H:%M:%SZ") --end-time $(gdate -u +"%Y-%m-%dT%H:%M:%SZ")  --period 86400 --statistics "Maximum"
```

## Resources

* cloudwatch cli [here](https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html)
