# IAM

Demonstrate how to use awscli to manage policies, roles and users.  

NOTES:

* There doesn't currently seem to be a way to do a "can I" check in AWS from the CLI. You can do it in the [policy simulator](https://policysim.aws.amazon.com/home/index.jsp?#roles)  

## Find a role

```sh
AWS_PROFILE=myprofile aws iam list-roles | jq -r '.Roles[] | select(.RoleName | test(".*_mypattern"))'
```

## Find Policies 

```sh
# get policies for a role
aws iam list-attached-role-policies --role-name myrole | jq .

# get policy versions
aws iam list-policy-versions --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess" | jq .

# get the policy details for the version 
aws iam get-policy-version --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess" --version-id v1 | jq .
```

## Resources

* AWS IAM Users vs Groups vs Roles [here](https://www.learnaws.org/2022/09/27/aws-iam-roles-vs-groups/)  
