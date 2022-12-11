# XARGS

Demonstrate basic behaviour with `xargs`.  

TODO:

* `echo ../* | xargs -n1`
* `xargs -I {} gdate --date=@{}`
* `xargs -I % touch %`

## Examples

```sh
# iterate through the docker volumes printing createdat.  
docker volume ls --format '{{.Name}}' | xargs -L 1 docker volume inspect | jq -s -c '.[][0] | {CreatedAt, Name}'
```

## Resources
