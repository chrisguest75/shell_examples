# README

Demonstrates some examples of using jq to process json files

Github [JQ](https://github.com/stedolan/jq) repo.  

## Install

You can use linux or homebrew to install.  But ensure you hae version 1.6.  

```sh
# get version
jq --version  
```

## Tricks

```sh
# takes json logs and pretty print them 
pbpaste | jq '.'

# Take an array defined in json and loop over it in bash.
./loop_array.sh
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

# transform and output as csv (with a header)    
jq -cr '["Name","Id"], (.[][] | [.name, .id]) | @csv' ./pokedex.json     

# individual array items
jq -r ".[][2].img" ./pokedex.json

# extract height in metres 
jq -r ".[][].height | split(\" \") | .[0] | tonumber" ./pokedex.json
```

## Document creation and modification

Ref: Loading md5 values into a document [here](../63_md5_file_id/README.md)  

```sh
# add fields to an empty document - have to have {}
echo '{}' | jq --arg argument1 "value1" --arg argument2 "value2" '[. + {field1: $argument1, field2: $argument2, array_of_stuff: []} ]'  

# or use a null-input to construct
jq --null-input --arg argument1 "value1" --arg argument2 "value2" '[. + {field1: $argument1, field2: $argument2, array_of_stuff: []} ]' 

# Add a field to an existing document 
# merge in a processed on field (if field exists it will update it)
jq --arg date "$(date)" '. + {processed: $date}' ./pokedex.json

# Create index of files 
cat <<- EOF > "./files.json"
{
    "files": [
    ]
}
EOF
TEMPFILE=$(mktemp)
while IFS=, read -r _filename
do
    _no_extension="${_filename%.*}"
    echo "File ${_filename} exists as ${_no_extension}"
    jq --arg filename "${_no_extension}" '.files += [$filename]' "./files.json" > $TEMPFILE
    cp $TEMPFILE "./files.json"
done < <(ls ../)
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

## Field manipulation

```sh
# add a new field 
jq -r '. + {"newfield": "new field"}' ./base64.json

# delete a field 
jq -r '. | del(.normal)' ./base64.json
```

## APIs

```sh
# make webrequest and pretty print
curl -s https://registry.hub.docker.com/api/content/v1/repositories/public/library/bash/tags | jq    
```

## Terraform plans (pivot)

```sh
# group the actions into a single array, group the individual actions into seperate arrays, count entries and pivot key name "create" to become key name, then merge the results into a single object and add filename.   
for filename in ./*.tfplan.json; 
do
  jq --arg filename "${filename}" -r '. | [ .resource_changes[].change.actions[] ] | group_by(.) | map({(.[0]):length}) | reduce .[] as $x (null; . + $x) | . + {file:$filename }' "$filename"
done
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

## Regex Capture

```sh
# extract a number and use it to sort the documents
jq -s -c '.[] | . + { id: .file | capture("file(?<file>([[:digit:]]+))").file | tonumber}' ./hls_timecodes.json | jq -s -c '. | sort_by(.id) | .[]'
```

## Loading fields into environment vars

```sh
# output fields as env vars
while IFS=" ", read -r rootpath reponame default_branch commit origincommit current_branch on_default_branch modified unfetched_changes
do
    echo "rootpath=$rootpath, reponame=$reponame"
    echo "default_branch=$default_branch, current_branch=$current_branch, on_default_branch=$on_default_branch"
    echo "commit=$commit, origincommit=$origincommit"
    echo "modified=$modified, unfetched_changes=$unfetched_changes"
done < <(jq -c -r '.[] | "\(.rootpath) \(.reponame) \(.default_branch) \(.commit) \(.origincommit) \(.current_branch) \(.on_default_branch) \(.modified) \(.unfetched_changes)"' ./repos.json)
```

## Loading files into fields (--rawfile)

```sh
cat <<- EOF > "./frames.json"
{
    "frames": [
    ]
}
EOF
_filename="./danceloop_00009.svg"
_no_extension="${_filename%.*}"
_frame_number=$(echo ${_no_extension} | grep --color=never -o -E '[0-9]+')
jq --rawfile path ./README.md --arg filename "${_no_extension}" --arg number "${_frame_number}" '.frames += [ {"name":$filename, "path":$path, "number":$number | tonumber }]' "./frames.json"
```

## Propgating errors

Using `-e` to use the exitcode for detection of errors.  

```sh
WEAKNESS=Swimming
jq -e --arg weakness "$WEAKNESS" '.[][] | select(.weaknesses | contains( [$weakness] )) | .name' ./pokedex.json; if [[ $? != 0 ]] echo "$WEAKNESS not found"

WEAKNESS=Fighting
jq -e --arg weakness "$WEAKNESS" '.[][] | select(.weaknesses | contains( [$weakness] )) | .name' ./pokedex.json; if [[ $? != 0 ]] echo "$WEAKNESS not found"
```

## base64 handling

Simple examples of single field encoding and decoding.  

```sh
# create a base64 encoded string.
echo -n "this is a normal string" | base64

# decode a field
jq -r '.base64_normal | @base64d' ./base64.json

# encode a field
jq -r '.normal | @base64' ./base64.json
```

More complex decoding of fields and arrays  

```sh
# iterate over an array and encode the values
jq -r '. | .config.array_field | map_values(@base64)' ./base64_config.json

# decode the values in the array and reconstruct the document
jq '[ (. | del(.config)), (.config + { "array_field": .config.base64_array_field | map_values(@base64d) } | del(.base64_array_field) | { "config": (.)}) ] | reduce .[] as $merge (null; . + $merge)' ./base64_config.json  
```

## Resources

* jq 1.6 Manual [here](https://stedolan.github.io/jq/manual/v1.6/)
* jq: JSON - Like a Boss [here](https://www.slideshare.net/btiernay/jq-json-like-a-boss)  
* [jq cookbook](https://github.com/stedolan/jq/wiki/Cookbook)  
* ```cheatsheet jq```
* jq recipes [here](https://remysharp.com/drafts/jq-recipes)  
* Processing JSON using jq [cheatsheet](https://gist.github.com/olih/f7437fb6962fb3ee9fe95bda8d2c8fa4)  
* Example [modules](https://github.com/stedolan/jq/wiki/Modules)
* Example [pokedex](https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json) json file
* Guide to Linux jq Command for JSON Processing [here](https://www.baeldung.com/linux/jq-command-json)
* How to add a header to CSV export in jq? [here](https://stackoverflow.com/questions/30015555/how-to-add-a-header-to-csv-export-in-jq)

