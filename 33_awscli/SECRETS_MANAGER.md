# SECRETS MANAGER

Demonstrate some basics with secrets manager.  

```sh
# list available secrets
aws secretsmanager list-secrets | jq .

# get the secret value
aws --no-cli-pager secretsmanager get-secret-value --secret-id "ecr-pullthroughcache/myvalue" | jq .
```

## Resources

