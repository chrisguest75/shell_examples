# Cloudwatch

Demonstrate some example commands for managing Cloudwatch.  

NOTE:

* Cloudwatch Alarms are regional

## Alarms

```sh
export AWS_PAGER=

# list alarm names
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch describe-alarms | jq '.MetricAlarms[].AlarmName'

# show an alarm
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch describe-alarms | jq 'select(.MetricAlarms[].AlarmName == "alarm-name-to-look-for")'

# output alarms with action
aws --profile ${AWS_PROFILE} --region ${AWS_REGION}  cloudwatch describe-alarms | jq -c '.MetricAlarms[] | {name: .AlarmName, action:.AlarmActions[0]}' | jq -s -c  'sort_by(.action)' | jq -c '.[]'

# patching in profile and region
aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch describe-alarms | jq  --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" -c '.MetricAlarms[] | {profile: $profile, region: $region, name: .AlarmName, action:.AlarmActions[0]}' | jq -s -c  'sort_by(.action)' | jq -c '.[]'

# loop over multiple profiles and regions (writes out ./alarms.json)
while IFS=, read -r AWS_PROFILE AWS_REGION
do
    aws --profile ${AWS_PROFILE} --region ${AWS_REGION} cloudwatch describe-alarms | jq --arg profile ${AWS_PROFILE} --arg region "${AWS_REGION}" -c '.MetricAlarms[] | {profile: $profile, region: $region, name: .AlarmName, action:.AlarmActions[0]}' | jq -s -c 'sort_by(.action)' | jq -c '.[]'
done << EOF > ./alarms.json
profile1,us-east-1
profile1,eu-west-1
profile2,us-east-1
profile1,eu-west-1
profile3,us-east-1
profile3,eu-west-1
EOF

# sort and filter alarms 
jq -s '[.[].action] | sort | unique' ./alarms.json | jq -r '.[]' | grep sns
```

## Resources

* cloudwatch cli [here](https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html)

