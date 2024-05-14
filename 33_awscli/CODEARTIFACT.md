# CODEARTIFACT

Demonstrate some commands with CodeArtifact.  

TODO:

* Create a domain and repository

NOTES:

- CodeArtifact supports NPM, pypi and generic artifacts.  
- Downloading a generic artifact still requires `awscli`.  

## Contents

- [CODEARTIFACT](#codeartifact)
  - [Contents](#contents)
  - [Prepare](#prepare)
  - [Login](#login)
  - [Pipenv](#pipenv)
  - [Interrogate](#interrogate)
  - [Generic Packages](#generic-packages)
  - [Resoures](#resoures)

## Prepare

```sh
export AWS_PROFILE=my-profile
export AWS_REGION=us-east-1 
export PAGER=
```

## Login

```sh
# get name, domainname and domainowner for login
aws codeartifact list-repositories

aws codeartifact list-repositories | jq '.repositories[] | select(.name == "codeartifact-test")'

export CODEARTIFACT_DOMAIN=mydomain
export CODEARTIFACT_DOMAIN_OWNER=000000000000
export CODEARTIFACT_REPOSITORY=myrepo

# login; supported tools swift | nuget |dotnet | npm | pip | twine  
aws codeartifact login --tool pip --repository ${CODEARTIFACT_REPOSITORY}  --domain ${CODEARTIFACT_DOMAIN} --domain-owner ${CODEARTIFACT_DOMAIN_OWNER}
```

## Pipenv

Pipenv is not a supported tool.  

```sh
export CODEARTIFACT_DOMAIN mydomain
export CODEARTIFACT_DOMAIN_OWNER 000000000000
export CODEARTIFACT_REPOSITORY myrepo

export CODEARTIFACT_AUTHTOKEN=$(aws --profile $AWS_PROFILE codeartifact get-authorization-token --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_DOMAIN_OWNER --query authorizationToken --output text)
export CODEARTIFACT_URL="https://aws:${CODEARTIFACT_AUTHTOKEN}@${CODEARTIFACT_DOMAIN}-${CODEARTIFACT_DOMAIN_OWNER}.d.codeartifact.${AWS_REGION}.amazonaws.com/pypi/${CODEARTIFACT_REPOSITORY}/simple/"
echo $CODEARTIFACT_URL
```

Modify your `Pipfile`

```ini
[[source]]
url = "${CODEARTIFACT_URL}"
verify_ssl = true
name = "privatecodeartifact"

[[packages]]
my_library = {version="1.2.3", index="privatecodeartifact"}
```

## Interrogate

```sh
# describe repository metadata
aws codeartifact describe-repository --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_DOMAIN_OWNER --repository ${CODEARTIFACT_REPOSITORY}

# list packages in a repository
aws codeartifact list-packages --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_DOMAIN_OWNER --repository ${CODEARTIFACT_REPOSITORY}

# get versions of a package
aws codeartifact list-package-versions --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_DOMAIN_OWNER --repository ${CODEARTIFACT_REPOSITORY} --package codeartifact_test_package --format pypi

# get dependencies
aws codeartifact list-package-version-dependencies --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_DOMAIN_OWNER --repository ${CODEARTIFACT_REPOSITORY} --package codeartifact_test_package --format pypi --package-version 0.0.2
```

## Generic Packages

```sh
mkdir -p ./generic-package/in ./generic-package/out

cat >./generic-package/in/files.txt <<EOF
CODEARTIFACT.md
BATCH.md
EOF

# create a tar from a list of files
tar -a -cvf ./generic-package/out/test.tar.gz -T ./generic-package/in/files.txt

export ASSET_SHA256=$(sha256sum ./generic-package/out/test.tar.gz | awk '{print $1;}')
echo $ASSET_SHA256

# publish package
aws codeartifact publish-package-version --domain $CODEARTIFACT_DOMAIN --repository $CODEARTIFACT_REPOSITORY --format generic --namespace my-ns --package test-generic-package --package-version 1.0.0  --asset-content ./generic-package/out/test.tar.gz --asset-name test.tar.gz --asset-sha256 $ASSET_SHA256

# download package
aws codeartifact get-package-version-asset --domain $CODEARTIFACT_DOMAIN --repository $CODEARTIFACT_REPOSITORY --format generic --namespace my-ns --package test-generic-package --package-version 1.0.0 --asset test.tar.gz ./generic-package/out/downloaded-test.tar.gz
```

## Resoures

* AWS CodeArtifact concepts [here](https://docs.aws.amazon.com/codeartifact/latest/ug/codeartifact-concepts.html)
* codeartifact awscli [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/codeartifact/index.html)
* How to Import Private Python Packages with pipenv and Gitlab [here](https://medium.com/@matt_tich/how-to-use-private-python-packages-with-pipenv-and-gitlab-8d35f73e5329)
* Using CodeArtifact as Pypi mirror for Pipenv [gist](https://gist.github.com/smparekh/a2bf43e514f65b920c8ca8fb55aaefbb)
* Injecting credentials into Pipfile via environment variables [here](https://pipenv.pypa.io/en/latest/credentials.html)
* Generic packages overview [here](https://docs.aws.amazon.com/codeartifact/latest/ug/generic-packages-overview.html)  
