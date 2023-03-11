# README

Example scripts.  

## Manifests for S3

A tools for generating manifests to check lists of files are valid in S3.  
The tool can be used for for pre-verification before running a set of tests relying on S3 data.  

### Generation

```sh
mkdir -p ./manifests

AWS_PROFILE=myprofile
SOURCE_BUCKET=mybucket
SOURCE_PREFIX=prefix
./s3manifest.sh --generate --profile=${AWS_PROFILE} --bucket=${SOURCE_BUCKET} --prefix=${SOURCE_PREFIX}/ --manifest=./manifests/${SOURCE_PREFIX}.manifest.json

while IFS=, read -r _prefix
do
    ./s3manifest.sh --generate --profile=${AWS_PROFILE} --bucket=${SOURCE_BUCKET} --prefix=${_prefix}/ --manifest=./manifests/${_prefix}.manifest.json
done << EOF
myprefix1
myprefix2
myprefix3
EOF

while IFS=, read -r _prefix
do
    ./s3manifest.sh --generate --profile=${AWS_PROFILE} --bucket=${SOURCE_BUCKET} --prefix=${_prefix}/ --manifest=./manifests/${_prefix}.manifest.json
done <(cat ./bucketlist.txt)
```

### Check

```sh
AWS_PROFILE=myprofile
SOURCE_PREFIX=prefix
./s3manifest.sh --check --manifest=./manifests/${SOURCE_PREFIX}.manifest.json --profile=${AWS_PROFILE}
```

## Resources
