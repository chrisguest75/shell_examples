# README

```sh
# Strip double quotes from field.
jq '.channel' --raw-output
```

```sh
# NOTE: If using array indexers it needs to be quoted. 
jq '.blocks[1].text.text' --raw-output
```

gcloud compute instances list --filter='name ~ ^prod-*' --format='json' | jq '.[] | "\(.name), \(.networkInterfaces[0].networkIP)"'



jq "(.[] | select(.name | contains(\"k8s-eu-workers\")) | {name, launch_config, desired})" 

echo '{"key1":"val1", "myarray":["abc", "def", "ghi"]}' | jq -r '.myarray | @csv'

aws route53 list-hosted-zones | jq -r ".[][].Name" | sort | sed "s/^/\\$AWS_OKTA_PROFILE /"

	curl https://registry.hub.docker.com/api/content/v1/repositories/public/library/bash/tags | jq

export BASELAYER=$(docker inspect ubuntu:18.04 | jq ".[].GraphDriver.Data.LowerDir | split(\":\")[-1]" --raw-output)

https://dev.to/olore/jq-the-json-cli-tool-2om0

https://github.com/stedolan/jq/wiki/Cookbook

https://michaelheap.com/extract-keys-using-jq/

https://github.com/stedolan/jq

http://rosettacode.org/wiki/Strip_control_codes_and_extended_characters_from_a_string#jq


