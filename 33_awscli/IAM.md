# IAM

Demonstrate how to use awscli to manage policies, roles and users.  

## Find a role

```sh
AWS_PROFILE=myprofile aws iam list-roles | jq -r '.Roles[] | select(.RoleName | test(".*_mypattern"))'
```

## Resources

* AWS IAM Users vs Groups vs Roles [here](https://www.learnaws.org/2022/09/27/aws-iam-roles-vs-groups/)  
