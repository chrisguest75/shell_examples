# GCP Shell Examples

## Help

```sh
# turn off pagination
export PAGER=cat
gcloud help
```

## List Projects

```sh
gcloud projects list
```

## List Resources

```sh
gcloud asset search-all-resources --scope projects/[projectname]
```

## Resources

- [GCP Documentation](https://cloud.google.com/docs)
- [gcloud CLI Reference](https://cloud.google.com/sdk/gcloud/reference)