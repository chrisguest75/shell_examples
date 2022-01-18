# Elastic Container Services

Container Instances are the hosts tasks are the pods.  

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION ecs help
```

## List clusters  

```sh
# list the clusters in the region
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-clusters
```


```sh
# give information on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs describe-clusters --cluster "$cluster"

# what container instances are on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-container-instances --cluster "$cluster"

# what tasks are running
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-tasks --cluster "$cluster"


```



## Resources  

https://medium.com/boltops/gentle-introduction-to-how-aws-ecs-works-with-example-tutorial-cea3d27ce63d

https://cloud.netapp.com/blog/aws-cvo-blg-aws-ecs-in-depth-architecture-and-deployment-options