# README
Demonstrates some examples of using jq to process json files

[Github JQ](https://github.com/stedolan/jq)

```sh
# get version
jq --version  
```

## Tricks
```sh
# takes json logs and pretty print them 
pbpaste | jq '.'
```

## Transforming and Processing files
```sh
# Strip double quotes from field.
# NOTE: If using array indexers it needs to be quoted. 
cat ./pokedex.json | jq ".[][].name" --raw-output

# extract multiple fields
cat ./pokedex.json | jq -c ".[][] | {name, id}"    

# transform and output as json
jq -c ".[][] | {name, id}" ./pokedex.json 

# transform and output as fields    
jq -c ".[][] | (.name, .id)" ./pokedex.json

# transform and output as csv     
jq -cr ".[][] | [.name, .id] | @csv" ./pokedex.json     

# individual array items
jq -r ".[][2].img" ./pokedex.json

# extract height in metres 
jq -r ".[][].height | split(\" \") | .[0] | tonumber" ./pokedex.json
```

## Selecting and Filtering
```sh
# filtering by value
jq -r ".[][] | select(.id == 150)" ./pokedex.json 

# greater than
jq -r ".[][] | select(.id > 150)" ./pokedex.json 

# filter by a value passed as an argument
jq --arg myid 150 -r '.[][] | select(.id == ($myid | tonumber))' ./pokedex.json 

# argjson does implicit conversion to type number
jq --argjson myid 120 -r '.[][] | select(.id == $myid)' ./pokedex.json 

# filter and transform fields as json
jq -r ".[][] | select(.id == 150) | {name, id}" ./pokedex.json 

# if array contains an element then return object
jq -r '.[][] | select(.weaknesses | contains( ["Rock"] ))' ./pokedex.json 
```

## Aggregations

```sh
# count objects in array
jq -r ".[] | length" ./pokedex.json 

# show all possible weaknesses
jq -r "[.[][].weaknesses] | flatten | unique" ./pokedex.json 

# count how many records have weakness of flying
jq -r '.[][] | select(.weaknesses | contains( ["Flying"] )) | .id' ./pokedex.json | jq --slurp '. | length'
```

## Functions
```sh
# print out a basic json object paths 
jq -r 'def schema($path): $path | paths | map(tostring) | join("/"); schema(.[][2])' ./pokedex.json
```

## Modules
```sh
# load schema function from a module
export ORIGIN=$(pwd)/lib
echo '{"a":{"c":2}, "b":2}' | jq 'import "schema" as lib; lib::schema(.)'

# load schema from global module
cp ./lib/schema.jq ~/.jq    
echo '{"a":{"c":2}, "b":2}' | jq 'schema(.)'
rm ~/.jq   
```

## Joining datasets

```sh
# multiple streams from a single document 
jq -c '(.[][] | {name, id}), (.[][] | select(.weaknesses | contains( ["Rock"])) | { "name": .name, "weakness": "rock" })' ./pokedex.json 
```


## APIs
```sh
# make webrequest and pretty print
curl -s https://registry.hub.docker.com/api/content/v1/repositories/public/library/bash/tags | jq    
```

# Resources
* [jq-json-like-a-boss](https://www.slideshare.net/btiernay/jq-json-like-a-boss)  
* [jq cookbook](https://github.com/stedolan/jq/wiki/Cookbook)  
* ```cheatsheet jq```    
* [jq-recipes](https://remysharp.com/drafts/jq-recipes)  
* [cheatsheet](https://gist.github.com/olih/f7437fb6962fb3ee9fe95bda8d2c8fa4)  
