# CODEARTIFACT

Demonstrate some commands with CodeArtifact.  

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

## Resoures

* codeartifact awscli [here](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/codeartifact/index.html)
* How to Import Private Python Packages with pipenv and Gitlab [here](https://medium.com/@matt_tich/how-to-use-private-python-packages-with-pipenv-and-gitlab-8d35f73e5329)
* Using CodeArtifact as Pypi mirror for Pipenv [gist](https://gist.github.com/smparekh/a2bf43e514f65b920c8ca8fb55aaefbb)
* Injecting credentials into Pipfile via environment variables [here](https://pipenv.pypa.io/en/latest/credentials.html)