# SPOT INSTANCES

NOTES:

* It takes into account quota - so asking for more than your quota will fail.

```sh
# query a default query
aws ec2 get-spot-placement-scores --region us-east-1 --generate-cli-skeleton

# use query
aws ec2 get-spot-placement-scores --region us-east-1 --cli-input-json file://file_name.json

# get instance types
AWS_PAGER= aws ec2 describe-instance-types --query 'InstanceTypes[?GpuInfo!=`null`].{InstanceType: InstanceType, GPU: GpuInfo.Gpus[0].Name, GPUCount: GpuInfo.Gpus[0].GpuCount}' --output table
```

```txt
--------------------------------------------------
|              DescribeInstanceTypes             |
+------------------+-----------+-----------------+
|        GPU       | GPUCount  |  InstanceType   |
+------------------+-----------+-----------------+
|  L40S            |  None     |  g6e.8xlarge    |
|  A10G            |  None     |  g5.4xlarge     |
|  L4              |  None     |  g6.24xlarge    |
|  A10G            |  None     |  g5.2xlarge     |
|  L40S            |  None     |  g6e.48xlarge   |
|  L4              |  None     |  g6.48xlarge    |
|  Radeon Pro V520 |  None     |  g4ad.4xlarge   |
|  T4              |  None     |  g4dn.metal     |
|  L4              |  None     |  g6.8xlarge     |
|  L40S            |  None     |  g6e.16xlarge   |
|  A10G            |  None     |  g5.24xlarge    |
|  Radeon Pro V520 |  None     |  g4ad.8xlarge   |
|  T4g             |  None     |  g5g.2xlarge    |
|  Radeon Pro V520 |  None     |  g4ad.2xlarge   |
|  L40S            |  None     |  g6e.12xlarge   |
|  T4              |  None     |  g4dn.12xlarge  |
|  V100            |  None     |  p3.2xlarge     |
|  T4g             |  None     |  g5g.16xlarge   |
|  A100            |  None     |  p4de.24xlarge  |
|  A10G            |  None     |  g5.12xlarge    |
|  H100            |  None     |  p5.48xlarge    |
|  A100            |  None     |  p4d.24xlarge   |
|  T4              |  None     |  g4dn.xlarge    |
|  T4g             |  None     |  g5g.metal      |
|  T4g             |  None     |  g5g.8xlarge    |
|  A10G            |  None     |  g5.16xlarge    |
|  A10G            |  None     |  g5.xlarge      |
|  L4              |  None     |  g6.2xlarge     |
|  L4              |  None     |  g6.12xlarge    |
|  H200            |  None     |  p5en.48xlarge  |
|  L4              |  None     |  g6.16xlarge    |
|  L4              |  None     |  g6.xlarge      |
|  V100            |  None     |  p3.16xlarge    |
|  L40S            |  None     |  g6e.4xlarge    |
|  L4              |  None     |  gr6.4xlarge    |
|  T4              |  None     |  g4dn.16xlarge  |
|  L4              |  None     |  gr6.8xlarge    |
|  Radeon Pro V520 |  None     |  g4ad.16xlarge  |
|  L4              |  None     |  g6.4xlarge     |
|  A10G            |  None     |  g5.8xlarge     |
|  L40S            |  None     |  g6e.xlarge     |
|  L40S            |  None     |  g6e.2xlarge    |
|  Gaudi HL-205    |  None     |  dl1.24xlarge   |
|  T4              |  None     |  g4dn.8xlarge   |
|  T4              |  None     |  g4dn.4xlarge   |
|  Radeon Pro V520 |  None     |  g4ad.xlarge    |
|  T4g             |  None     |  g5g.4xlarge    |
|  L40S            |  None     |  g6e.24xlarge   |
|  T4g             |  None     |  g5g.xlarge     |
|  A10G            |  None     |  g5.48xlarge    |
|  V100            |  None     |  p3.8xlarge     |
|  V100            |  None     |  p3dn.24xlarge  |
|  T4              |  None     |  g4dn.2xlarge   |
+------------------+-----------+-----------------+
```

## Resources

* Calculate the Spot placement score [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-spot-placement-score.html)
* L40S - https://www.nvidia.com/en-gb/data-center/l40s/
* A10G - https://www.nvidia.com/en-gb/data-center/products/a10-gpu/
* L4 - https://www.nvidia.com/en-gb/data-center/l4/
* H100 - https://www.nvidia.com/en-gb/data-center/h100/
* V100 - https://www.nvidia.com/en-gb/data-center/tesla-v100/
* https://docs.aws.amazon.com/batch/latest/userguide/bestpractice6.html
