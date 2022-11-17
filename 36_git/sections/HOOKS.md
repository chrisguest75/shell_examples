# HOOKS

Examples relating to `git hooks`.  

## Removing hooks

```sh
# delete all none sample hooks
find $(git root)/.git/hooks ! -name '*.sample' -print -delete 
```

