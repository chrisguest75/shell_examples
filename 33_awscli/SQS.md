# SQS

Demonstrate how to use SQS commands from AWS CLI.  

TODO:

* SQS logs

NOTES:

* Empty receives are logged when the queue is being polled but it's empty.  
* DLQ - Dead Letter Queues.  

## Listing

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION --no-cli-pager sqs list-queues
```

## Statistics (queue attributes)

```sh
# we need the full url for the queue
export QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/000000000000/my-dlq.fifo
aws --profile $AWS_PROFILE --region $AWS_REGION --no-cli-pager sqs get-queue-attributes --attribute-names All --queue-url $QUEUE_URL
```

## Receive Messages

```sh
# this will poll for messages.  It it non-deterministic and may return no results. 
export QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/000000000000/my-dlq.fifo
aws --profile $AWS_PROFILE --region $AWS_REGION --no-cli-pager sqs receive-message --wait-time-seconds 10 --message-attribute-names All --max-number-of-messages 10 --attribute-names All --queue-url $QUEUE_URL
```

## Resources

* Monitoring AWS SQS [here](https://medium.com/geekculture/monitoring-aws-sqs-53b34455788d)
* How to use the AWS SQS CLI to receive messages [here](https://advancedweb.hu/how-to-use-the-aws-sqs-cli-to-receive-messages/)  
* SQS aws cli docs [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sqs/index.html#cli-aws-sqs)  
