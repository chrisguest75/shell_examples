# CLOUDTRAIL

AWS CloudTrail is a service provided by Amazon Web Services (AWS) that helps you to log, continuously monitor, and retain account activity related to actions across your AWS infrastructure. This service provides event history of your AWS account activity, including actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services. This event history simplifies security analysis, resource change tracking, and troubleshooting.  

Here's what CloudTrail allows you to do:

* Audit and Compliance: It helps you to ensure compliance with internal policies and regulatory standards by providing a history of activity in your AWS environment.

* Visibility: You can have full visibility into user and resource activity in your AWS account.

* Security Analysis and Troubleshooting: By keeping an extensive log of actions, it allows you to investigate security incidents or operational problems within your AWS account.

* Automation and Integration: CloudTrail integrates with other AWS services such as Amazon CloudWatch Logs and Amazon S3, which allows for further automation and analysis of log data.

Key Features of CloudTrail:

* Event History: View the most recent events in your AWS account.
* Management Events: Record management operations on resources in your AWS account.
* Data Events: Record resource operations performed on or within a resource.
* Event Delivery: The ability to specify an S3 bucket for the delivery of event logs.
* Lookup and Filtering: Find and filter events by various criteria.
* Multi-region Configuration: Record events in all regions and get logs delivered to a single S3 bucket.
* Account Aggregation: Aggregate CloudTrail logs across multiple accounts into a single S3 bucket for centralized auditing.

CloudTrail provides a record of actions taken by a user, role, or an AWS service in CloudTrail Management Console. For example, CloudTrail can log API calls made to specific AWS services, console sign-in events, and even account-level actions such as activating multi-factor authentication (MFA) on root account.  

It's an essential service for anyone who needs to perform security analysis, track changes to AWS resources, or troubleshoot operational issues, ensuring that every API call is recorded for any future investigation or audit.  

TODO:

* Find out how to search the events - athena

```sh
# list trails
aws --no-cli-pager --profile $AWS_PROFILE cloudtrail list-trails

# list trail details
aws --no-cli-pager --profile $AWS_PROFILE cloudtrail describe-trails

# the name is the full trail ARN
aws --no-cli-pager --profile $AWS_PROFILE cloudtrail get-trail-status --name "arn:aws:cloudtrail:us-east-1:account:trail/name"
```

## Resources

