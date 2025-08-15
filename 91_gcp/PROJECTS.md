# PROJECTS

## List Organizations

Find organization ids

```sh
gcloud organizations list
```

## List Projects

Listing projects in the current organization

```sh
gcloud projects list
```

## Folders

```sh
# list folders
gcloud resource-manager folders list --organization 000000000000

# list subfolders
gcloud resource-manager folders list --folder=111111111111

# create a folder
gcloud resource-manager folders create --display-name="urbane" --organization=000000000000

# create a project in the folder
gcloud projects create my-staging-01 --name="my-staging-01" --folder=111111111111
```

## Resources

