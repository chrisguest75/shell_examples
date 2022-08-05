# Simple Notification Service SNS

Demonstrate some example commands for managing SNS.  

```sh
# list topics 
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} sns list-topics                      

# describe a topic
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} sns list-subscriptions-by-topic --topic-arn "arn:aws:sns:us-east-1:accountid:topicname"
```

## Resources

* SNS cli [here](https://docs.aws.amazon.com/cli/latest/reference/sns/index.html)
