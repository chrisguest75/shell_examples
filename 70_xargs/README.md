# XARGS

Demonstrate basic behaviour with `xargs`.  

## Examples

xargs – construct argument list(s) and execute utility

```sh
# iterate through the docker volumes printing createdat.  
docker volume ls --format '{{.Name}}' | xargs -L 1 docker volume inspect | jq -s -c '.[][0] | {CreatedAt, Name}'

# find files beginning with 70* and show disk space
find $(git root) -iname "70*" | xargs -L 1 du -s

# for each value 
read -r -d '' TIMES <<'EOF'
4922049292
3420302882
1334423422
EOF
echo $TIMES | xargs -I {} gdate --date=@{}
```

## Resources

* How to assign a heredoc value to a variable in Bash? [here](https://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash)  
