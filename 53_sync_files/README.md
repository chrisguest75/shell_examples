# README

Demonstrate some examples on syncing directories

## Examples

```sh
# copy new files over to share skipping ones that are newer in destination
rsync -vv --update -r output/* ~/shares/share
```

## Resources

* `cheatsheet rsync`
