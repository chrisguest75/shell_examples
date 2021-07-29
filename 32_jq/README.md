# README
Demonstrates some examples of using jq to process json files

TODO: 
* removing nodes in the document

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

# transform and output as fields (multiple lines)   
jq -c ".[][] | (.name, .id)" ./pokedex.json

# transform and output as fields (single line sing string interpolation)   
jq -c -r '.[][] | "\(.name) \(.id)"' ./pokedex.json

# transform and output as csv     
jq -cr ".[][] | [.name, .id] | @csv" ./pokedex.json     

# individual array items
jq -r ".[][2].img" ./pokedex.json

# extract height in metres 
jq -r ".[][].height | split(\" \") | .[0] | tonumber" ./pokedex.json
```
## Document creation and modification
```sh
# add fields to an empty document - have to have {}
echo '{}' | jq --arg argument1 "value1" --arg argument2 "value2" '[. + {field1: $argument1, field2: $argument2, array_of_stuff: []} ]'  

# or use a null-input to construct
jq --null-input --arg argument1 "value1" --arg argument2 "value2" '[. + {field1: $argument1, field2: $argument2, array_of_stuff: []} ]' 

# Add a field to an existing document 
# merge in a processed on field (if field exists it will update it)
jq --arg date "$(date)" '. + {processed: $date}' ./pokedex.json
```

## Selecting and Filtering
```sh
# filtering by value
jq -r ".[][] | select(.id == 150)" ./pokedex.json 

# greater than
jq -r ".[][] | select(.id > 150)" ./pokedex.json 

# boolean conditions "or"
jq -r ".[][] | select(.id > 150 or .id == 3)" ./pokedex.json 

# filter by a value passed as an argument (--arg is always a string) 
jq --arg myid 150 -r '.[][] | select(.id == ($myid | tonumber))' ./pokedex.json 

# argjson does implicit conversion to type number
jq --argjson myid 120 -r '.[][] | select(.id == $myid)' ./pokedex.json 

# filter and transform fields as json
jq -r ".[][] | select(.id == 150) | {name, id}" ./pokedex.json 

# if array contains an element then return object
jq -r '.[][] | select(.weaknesses | contains( ["Rock"] ))' ./pokedex.json 
```

## Conditional checks
```sh
# Pulls all the data and then slurps it back into a single array. 
jq '.pokemon[] | { name: .name,  version: (if .version == null then 0 else .version end)}' ./pokedex.json | jq  -s '{pokemon: (.)}'
```

## Sorting
```sh
# sort by name
jq '.pokemon | sort_by(.name) | .[].name' ./pokedex.json 
```

## Aggregations

```sh
# count objects in array
jq -r ".[] | length" ./pokedex.json 

# show all possible weaknesses
jq -r "[.[][].weaknesses] | flatten | unique" ./pokedex.json 

# count how many records have weakness of flying
jq -r '.[][] | select(.weaknesses | contains( ["Flying"] )) | .id' ./pokedex.json | jq --slurp '. | length'

# group by candy and count
jq '.pokemon | group_by(.candy) | map({"candy":.[0].candy, "count":length})' ./pokedex.json 

# group names by candy type (map reduce)
jq '[ .pokemon[] | {"key":.candy, "value":.name} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] ))' ./pokedex.json
```

## Functions
You can create custom functions to reuse common functionality.
```sh
# print out a basic json object paths 
jq -r 'def schema($path): $path | paths | map(tostring) | join("/"); schema(.[][2])' ./pokedex.json
```

## Modules
It's possible to store functions in modules for sharing.
More information is available at [manual](https://stedolan.github.io/jq/manual/#Modules) and
[wiki](https://github.com/stedolan/jq/wiki/Modules)  
```sh
# load schema function from a module
export ORIGIN=$(pwd)/lib
echo '{"a":{"c":2}, "b":2}' | jq 'import "schema" as lib; lib::schema(.)'

# load schema from global module
cp ./lib/schema.jq ~/.jq    
echo '{"a":{"c":2}, "b":2}' | jq 'schema(.)'
rm ~/.jq   
```

## Joining datasets (multiple streams)

```sh
# multiple streams from a single document 
jq -c '(.[][] | {name, id}), (.[][] | select(.weaknesses | contains( ["Rock"])) | { "name": .name, "weakness": "rock" })' ./pokedex.json 
```
## Merging fragments into files
Create fragments
```sh
mkdir -p ./out
# export a fragment containing pokemon with flying weakness
jq '.[][] | select(.weaknesses | contains( ["Flying"] )) | .name' ./pokedex.json | jq -s ". | { has_flying_weakness: .}" > ./out/flying_weakness_fragment.json

# export a fragment containing pokemon with psychic weakness
jq '.[][] | select(.weaknesses | contains( ["Psychic"] )) | .name' ./pokedex.json | jq -s ". | { has_psychic_weakness: .}" > ./out/psychic_weakness_fragment.json
```

Merge fragments
```sh
# merge the fragments into object stream
jq -n 'inputs' *fragment.json 

# controlled merge .[0] = document1, .[1] = document2
jq -s '{ "merged":{"a":.[0].has_flying_weakness, "b":.[1].has_psychic_weakness}}' ./flying_weakness_fragment.json ./psychic_weakness_fragment.json
```

## APIs
```sh
# make webrequest and pretty print
curl -s https://registry.hub.docker.com/api/content/v1/repositories/public/library/bash/tags | jq    
```

## More complex examples (docker scan outputs)
```sh
# group cves by severity - sort them and remove duplicates. 
jq '[ .vulnerabilities[] | {"key":.severity | ascii_downcase, "value":.identifiers.CVE[0]} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | {low:(.low + []) | sort | unique, high:(.high + []) | sort | unique, critical:(.critical + []) | sort | unique, medium:(.medium + []) | sort | unique}' ./nginx1_20_1.json

# group packages by severity and CVE.  
jq '[ .vulnerabilities[] | {"key":.severity | ascii_downcase, "value":{"value":.name, "key":.identifiers.CVE[0]}} ] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )) | . as $cve | keys[] | . as $sev |  { ($sev):($cve[.] | map([.] | from_entries) | reduce .[] as $o ({}; reduce ($o|keys)[] as $key (.; .[$key] += [$o[$key]] )))} ' ./nginx1_20_1.json
```

## Trim whitespace 
Use regex functions to trim whitespace  
Ref: [csv2json](../12_csv/README.md)  
```sh
# no trimming
jq --null-input --arg none "none" --arg leading "    leading" --arg trailing "trailing     " --arg both "   both    " '. + {none: $none, leading: $leading, trailing: $trailing, both: $both}'

# trimming whitespace
export ORIGIN=$(pwd)/lib
jq --null-input --arg none "none" --arg leading "    leading" --arg trailing "trailing     " --arg both "   both    " 'import "trim" as lib; . + {none: $none | lib::trim(.), leading: $leading | lib::trim(.), trailing: $trailing | lib::trim(.), both: $both | lib::trim(.)}' 
```

# Resources
* Manual [here](https://stedolan.github.io/jq/manual/v1.6/)
* [jq-json-like-a-boss](https://www.slideshare.net/btiernay/jq-json-like-a-boss)  
* [jq cookbook](https://github.com/stedolan/jq/wiki/Cookbook)  
* ```cheatsheet jq```    
* [jq-recipes](https://remysharp.com/drafts/jq-recipes)  
* [cheatsheet](https://gist.github.com/olih/f7437fb6962fb3ee9fe95bda8d2c8fa4)  
* [modules](https://github.com/stedolan/jq/wiki/Modules)
* [pokedex](https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json)  
