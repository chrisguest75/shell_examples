# README
Demonstrate how to map an input to an output

TODO:
* fuzzy match
* autocompletion

## Examples
```sh
./get_mapped_value.sh account1 ./test.map
```

```sh
export MAP_FILE=./test.map
./get_mapped_value.sh account5
```

## Run npx from gist
```sh
# create gist
gh gist create --public get_mapped_value.sh package.json
gh gist list   
# view gist 
gh gist view db3559020e689452ca4a5d91ee02d9c3 --web   
# grab the url and run from a gist
npx https://gist.github.com/db3559020e689452ca4a5d91ee02d9c3

gh gist delete db3559020e689452ca4a5d91ee02d9c3 
```
## Resources 
[Checking sourcing](https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)  
