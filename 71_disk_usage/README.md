# DISK USAGE

Demonstrate some examples of calculating disk usage.

## Examples

```sh
# find files or folders and show disk space used for them. 
find /output -iname "share" -or -iname "include" | xargs du -sh

# summarise each folder (depth 1)
echo ../* | du -h -d1
```

## Resources
