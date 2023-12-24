# LOGS

Cloudwatch Logs.  

## Groups

```sh
# list groups
aws --no-cli-pager logs describe-log-groups --query 'logGroups[*]' | jq .

# list names
aws logs describe-log-groups --query 'logGroups[*].logGroupName' | jq .

# show sizes, dates and names
aws logs describe-log-groups --query 'logGroups[?storedBytes==`0`]' | jq -c '.[] | [.storedBytes, (.creationTime | (./1000 | strftime("%Y-%m-%d %H:%M:%S"))), .logGroupName]'
```

## Resouces
