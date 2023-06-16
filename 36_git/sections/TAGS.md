# TAGS

Demonstrate how to use tags with git.  

## Clone repository

```sh
gh repo clone kubernetes/ingress-nginx    
```

## Tags

```sh
# list tags
git tag

# sync to a tag
git checkout helm-chart-3.31.0
git checkout helm-chart-4.0.1
git checkout helm-chart-3.41.0
```

## Check tag format

The git check-ref-format command is used to ensure that a reference name (like a branch, tag, etc.) is well-formed.  

```sh
git check-ref-format "tags/0.0.1-a39f8a821fc9" 
```

## Diffing tags

```sh
# show files with diff in a specific folder
git diff --summary helm-chart-3.31.0..helm-chart-4.0.1 -- ./charts/

# diff files
git diff helm-chart-3.31.0..helm-chart-4.0.1 -- ./charts/ 
```

## Resources
