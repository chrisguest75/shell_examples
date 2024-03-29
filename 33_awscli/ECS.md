# Elastic Container Services

Container Instances are the hosts tasks are the pods.  

TODO:

* ecs-cli - ecs local https://docs.docker.com/cloud/ecs-integration/
* https://nathanpeck.com/diving-into-amazon-ecs-task-history-with-container-insights/

## Help

```sh
aws --profile $AWS_PROFILE --region $AWS_REGION ecs help
```

## List clusters  

Finding the ECS clusters.  

```sh
# list the clusters in the region
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-clusters
```

## Cluster tasks

Discovering tasks and interrogating them.  

```sh
# give information on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs describe-clusters --cluster "$cluster"

# what container instances are on the cluster
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-container-instances --cluster "$cluster"

# what tasks are running
aws --profile $AWS_PROFILE --region $AWS_REGION ecs list-tasks --cluster "$cluster"

# provide details on a task
aws --profile $AWS_PROFILE --region $AWS_REGION ecs describe-tasks 
--cluster "$cluster" --tasks "arn:aws:ecs:region:account:task/id"

# stop a task (will take 30 seconds without a init-process)
aws --profile $AWS_PROFILE --region $AWS_REGION ecs stop-task 
--cluster "$cluster" --task "arn:aws:ecs:region:account:task/id"
```

## Task Definitions

Finding out configuration foe task via the task definitions.  

```sh
# get the active task definition
 aws --no-cli-pager --profile "$AWS_PROFILE" --region "$AWS_REGION" ecs list-task-definitions --family-prefix "mytask" --status ACTIVE --sort DESC --max-items 1 --query 'taskDefinitionArns[0]' --output text

# now display it
aws --no-cli-pager --profile "$AWS_PROFILE" --region "$AWS_REGION" ecs describe-task-definition --task-definition arn:aws:ecs:us-east-1:0000000000000:task-definition/mytask:version```

## Resources  

* Gentle Introduction to How AWS ECS Works with Example Tutorial [here](https://medium.com/boltops/gentle-introduction-to-how-aws-ecs-works-with-example-tutorial-cea3d27ce63d)
* AWS ECS in Depth: Architecture and Deployment Options [here](https://cloud.netapp.com/blog/aws-cvo-blg-aws-ecs-in-depth-architecture-and-deployment-options)
* describe-container-instances [here](https://docs.aws.amazon.com/cli/latest/reference/ecs/describe-container-instances.html)  
