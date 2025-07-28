# REGIONS

Simple commands for regions on awscli  

```sh
# list regions
AWS_PAGER=  aws ec2 describe-regions --query "Regions[].RegionName" 
```

```sh
# get availability zones for a region.
AWS_PAGER= aws ec2 describe-availability-zones --region us-east-1
```

## Resources

