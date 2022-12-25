# Organisations and Accounts

Demonstrate some commands for dealing with accounts.  

## List

```sh
aws organizations list-accounts | jq . 

# find id of an account
NAME=account-name
aws organizations list-accounts | jq -r -e --arg name "$NAME" '.Accounts[] | select(.Name == $name).Id'

# get the accountid if you don't have permission to list-accounts
aws sts get-caller-identity --query "Account" --output text
```

## Resources

* list-accounts awscli [here](https://docs.aws.amazon.com/cli/latest/reference/organizations/list-accounts.html)
