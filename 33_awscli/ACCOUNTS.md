# Organisations and Accounts

Demonstrate some commands for dealing with accounts.  

## List

```sh
aws organizations list-accounts | jq . 

# find id of an account
NAME=account-name
aws organizations list-accounts | jq -r -e --arg name "$NAME" '.Accounts[] | select(.Name == $name).Id'
```

## Resources

* list-accounts awscli [here](https://docs.aws.amazon.com/cli/latest/reference/organizations/list-accounts.html)
