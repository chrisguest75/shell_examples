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
gh gist view b6bf4770237e1307b3fef4ffa3d4a187 --web   
# grab the url and run from a gist
npx https://gist.github.com/b6bf4770237e1307b3fef4ffa3d4a187

gh gist delete b6bf4770237e1307b3fef4ffa3d4a187

```

## Run with curl from gist
```sh
export MAP_FILE=$(pwd)/test.map
ROLE=$(curl -s https://gist.githubusercontent.com/chrisguest75/b6bf4770237e1307b3fef4ffa3d4a187/raw/0f05f1ae43ce0102fe9394b6dead9d502876be0d/get_mapped_value.sh | bash -s account1)
echo $ROLE
```
## Resources 
[Checking sourcing](https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)  
