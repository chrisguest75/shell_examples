# README
Demonstrates some examples of using jq to process json files

[Github JQ](https://github.com/stedolan/jq)

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

# multiple fields
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

## Filering
```sh
# filtering by value
jq -r ".[][] | select(.id > 150)" ./pokedex.json 


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



