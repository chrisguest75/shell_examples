# ROUTE53

Demonstrate some common tasks with DNS in route53.  

## Hosted Zones

Get the hosted zones for an account.  

```sh
aws route53 list-hosted-zones-by-name | jq -c ".HostedZones[] | [.Name, .Id, .ResourceRecordSetCount]"

# without jq
aws route53 list-hosted-zones-by-name --dns-name "mydomain.com." --query "HostedZones[*].{id: Id, name: Name, ResourceRecordSetCount: ResourceRecordSetCount }" --output table
```

## Record Sets

```sh
aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/id"

# format as table
aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/id" --query 'ResourceRecordSets[*].{name:Name, type:Type, TTL: TTL}' --output table
aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/id" --query 'ResourceRecordSets[*].{name:Name, type:Type, TTL: TTL, PTR: ResourceRecords[0].Value, Target: AliasTarget.DNSName}' --output table

# get the record as json for specfic entry
aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/id" --query "ResourceRecordSets[?Name == 'myrecord.mydomain.com']"

# list records (myrecord.mydomain.com)
while IFS=, read -r hostedid
do
    echo "${hostedid}"
    aws route53 list-resource-record-sets --hosted-zone-id "${hostedid}" | jq ".ResourceRecordSets[].Name" 
done < <(aws route53 list-hosted-zones-by-name --dns-name "mydomain.com." --query "HostedZones[*].{id: Id }" --output text)
```

## Modification

The record will need to look like this to remove it [change-resource-record-sets](https://docs.aws.amazon.com/cli/latest/reference/route53/change-resource-record-sets.html)

```json
{
    "HostedZoneId": "/hostedzone/id",
    "ChangeBatch": {
      "Comment": "",
      "Changes": [
        {
          "Action": "DELETE",
          "ResourceRecordSet":
            {
                "Name": "myrecord.mydomain.com",
                "Type": "CNAME",
                "TTL": 300,
                "ResourceRecords": [
                    {
                        "Value": "myendpoint.com"
                    }
                ]
            }
        }
    ]
}
}
```

```sh
# modify
aws route53 change-resource-record-sets --cli-input-json file://record.json

# check stastus
aws route53 get-change --id /change/C3RJ6YPQRNEZJA
```

