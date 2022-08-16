# Elastic Container Services

Container Instances are the hosts tasks are the pods.  

TODO:

* ecs-cli - ecs local https://docs.docker.com/cloud/ecs-integration/

## Help

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION ecs help
```

## List clusters  

```sh
# list the clusters in the region
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-clusters
```

## Cluster tasks

```sh
# give information on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs describe-clusters --cluster "$cluster"

# what container instances are on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-container-instances --cluster "$cluster"

# what tasks are running
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-tasks --cluster "$cluster"

# provide details on a task
aws --profile $AWS_PROFILE --region $AWS_REGION ecs describe-tasks --tasks "arn:aws:ecs:region:account:task/id"

```

## Resources  

* Gentle Introduction to How AWS ECS Works with Example Tutorial [here](https://medium.com/boltops/gentle-introduction-to-how-aws-ecs-works-with-example-tutorial-cea3d27ce63d)
* AWS ECS in Depth: Architecture and Deployment Options [here](https://cloud.netapp.com/blog/aws-cvo-blg-aws-ecs-in-depth-architecture-and-deployment-options)
* describe-container-instances [here](https://docs.aws.amazon.com/cli/latest/reference/ecs/describe-container-instances.html)  
