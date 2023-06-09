# COST EXPLORER

TODO:

* Can I do a query in cost explorer console and export it to json for use on cmdline?

## NOTES

* Use `fx` tool to help quickly parse the results. [antonmedv/fx](https://github.com/antonmedv/fx)  

## Accounts and Dimensions

```sh
aws organizations list-accounts | jq . 

export AWS_REGION=us-east-1
export AWS_PROFILE=myprofile

export DATE_RANGE=Start=2023-05-01,End=2023-06-01

# list active tags
aws ce list-cost-allocation-tags | jq '.CostAllocationTags[] | select(.Status == "Active")'
# list tags
aws ce get-tags --time-period "${DATE_RANGE}"

# get linked account details from the account we're querying
aws ce get-dimension-values --time-period "${DATE_RANGE}" --dimension LINKED_ACCOUNT

# lists all usage types 
aws ce get-dimension-values --time-period "${DATE_RANGE}" --dimension USAGE_TYPE

#aws ce get-dimension-values --dimension KEY --time-period Start=2023-03-01,End=2023-04-01 --include-all-features
```

## Cost and Usage

```sh
# USELESS - usage quantity is useless apparently
aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity DAILY --metrics UsageQuantity

# monthly cost for account
aws ce get-cost-and-usage --output json --time-period "${DATE_RANGE}" --granularity MONTHLY --metrics UnblendedCost --query 'ResultsByTime[*].Total.[UnblendedCost]' | jq '.[][0].Amount | tonumber*100 | round/100'

# breakdown per aws service (parse with fx)
aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity=MONTHLY --metrics BlendedCost --group-by Type=DIMENSION,Key=SERVICE | fx
```

Using file based queries.  

```sh
aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity=MONTHLY --metrics BlendedCost --filter file://./cost-queries/compounds_tags.json

aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity=MONTHLY --metrics BlendedCost --filter file://./cost-queries/compound_tags.json --group-by Type=DIMENSION,Key=SERVICE

# break down by instance type
aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity MONTHLY --metrics BlendedCost --filter file://./cost-queries/compound_tags.json --group-by Type=DIMENSION,Key=INSTANCE_TYPE

# costs aggregated by tags
aws ce get-cost-and-usage --time-period "${DATE_RANGE}" --granularity MONTHLY --metrics BlendedCost --group-by Type=TAG,Key=ServiceGroup
```

## Cost and Usage with Resources

```sh
# NOT WORKING (ensure date range is no longer than 14 days)
aws ce get-cost-and-usage-with-resources --time-period "${DATE_RANGE}" --granularity=DAILY --metrics BlendedCost --filter file://./cost-queries/resources_arn.json
```

## Resources

* You can use the Cost Explorer API to programmatically query your cost and usage data. [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ce/index.html)
* Retrieves cost and usage metrics for your account. [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ce/get-cost-and-usage.html)  
* Why does the "blended" annotation appear on some line items in my AWS bill? [here](https://repost.aws/knowledge-center/blended-rates-intro)
* AWS IAM and Cost Explorer CLI Setup [here](https://www.netmeister.org/blog/aws-cost-cli.html)
* Hello, Cost Explorer! [here](https://davidpallmann.hashnode.dev/hello-cost-explorer)  
