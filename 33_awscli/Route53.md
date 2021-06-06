# Route53

```sh
# get hosted zones  public and private for a domain
aws route53 list-hosted-zones-by-name --dns-name "mydomain.com."

aws route53 list-hosted-zones-by-name --dns-name "mydomain.com." --query "HostedZones[*].{name: Name, id: Id }" | jq -r ".[].id" 

# without jq
aws route53 list-hosted-zones-by-name --dns-name "mydomain.com." --query "HostedZones[*].{id: Id }" --output text

# list records (myrecord.mydomain.com)
while IFS=, read -r hostedid
do
    echo "${hostedid}"
    aws route53 list-resource-record-sets --hosted-zone-id "${hostedid}" | jq ".ResourceRecordSets[].Name" | grep myrecord
done < <(aws route53 list-hosted-zones-by-name --dns-name "mydomain.com." --query "HostedZones[*].{id: Id }" --output text)

# get the record as json
aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/id" --query "ResourceRecordSets[?Name == 'myrecord.mydomain.com']"
```

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
# 
aws route53 change-resource-record-sets --cli-input-json file://record.json

aws route53 get-change --id /change/C3RJ6YPQRNEZJA
```

