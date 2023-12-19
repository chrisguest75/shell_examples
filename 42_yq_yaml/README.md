# README

Demonstrates some examples of using `yq` to process yaml files  

It also can process xml [here](../52_xml/README.md)  

## Preeqs

```sh
brew info yq

brew install yq
brew upgrade yq

# using version 4.34.1 at time of writing
yq --version 
```

## Simple

```sh
# read and process
yq eval ./examples/simple.yaml 

# render with debugging 
yq eval -v ./examples/simple.yaml   

# extract a field
yq eval .image ./examples/simple.yaml 
```

## Anchors

```sh
# show internal representation of yaml
yq eval ./examples/anchors.yaml

# playing with anchors (THIS NO LONGER WORKS)
yq '. | explode(.)' ./examples/anchors.yaml  
```

## Merging

```sh
yq '. *= load("./examples/simple.yaml")' ./examples/anchors.yaml
```

Show an example of `docker compose` overrides.  

```sh
yq '. *= load("./docker-compose/docker-compose.override.yaml")' ./docker-compose/docker-compose.yaml
```

## Validation

```sh
yq -P ./examples/broken.yaml                
```

## Replace values

```sh
# replace a simple value
yq e '(.replacethis) |= "REPLACED"' ./examples/replace.yaml

# replace a substring
yq e '(.embedded) |= sub("\${APIKEY}", "theapikey")' ./examples/replace.yaml

# replace a value in an array
yq e '(.service[]) |= sub("\${APIKEY}", "theapikey")' ./examples/replace.yaml

# add a key value to an array
yq e '.extraEnvVars += [{"name": "VERDACCIO_PORT", "value": "4873"}]' ./examples/replace.yaml

# replace a value in a map
yq e '(.datasources.jsonData[]) |= sub("\${AWS_ROLE_ARN}", "arn:aws:iam::0000000000000:role/myrole")' ./examples/replace.yaml

# replace a value in a map for a specific key
yq e '(.datasources.jsonData["assumeRoleArn"]) |= "arn:aws:iam::0000000000000:role/myrole"' ./examples/replace.yaml
```

## Looping overs arrays in bash

Take an array defined in yaml and loop over it in bash.

```sh
# run the example script
./loop_array.sh
```

## Conversion

```sh
# read in json and output yaml
yq e --output-format=yaml ./json/images.json   
```

## Resources

* mikefarah/yq repo [here](https://github.com/mikefarah/yq)
* How It Works [here](https://mikefarah.gitbook.io/yq/how-it-works)
* Anchor and Alias Operators [here](https://mikefarah.gitbook.io/yq/operators/anchor-and-alias-operators)
* Multiply (Merge) [here](https://mikefarah.gitbook.io/yq/operators/multiply-merge)
* The yq gitbook has lots of good examples [here](https://mikefarah.gitbook.io/yq/upgrading-from-v3)
* yq: Mastering YAML Processing in Command Line [here](https://towardsdatascience.com/yq-mastering-yaml-processing-in-command-line-e1ff5ebc0823)
* Tips, Tricks, Troubleshooting [here](https://mikefarah.gitbook.io/yq/usage/tips-and-tricks)  
