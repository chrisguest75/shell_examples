# Configuration for new repos

When configuring a new repo consider the following.  

## Contents

- [Configuration for new repos](#configuration-for-new-repos)
  - [Contents](#contents)
  - [Creating](#creating)
  - [Conventional Commits](#conventional-commits)
  - [Adding LICENSE file](#adding-license-file)
  - [Adding CODEOWNERS](#adding-codeowners)
  - [Adding pipelines](#adding-pipelines)
  - [Adding branch protections](#adding-branch-protections)
  - [Resources](#resources)

## Creating

NOTE: Be careful to follow the github instructions.  

```sh
gh repo create my_repo --public
mkdir my_repo
git init
```

## Conventional Commits

```markdown
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)  

[![Repository](https://skillicons.dev/icons?i=bash,aws,git,linux,vscode)](https://skillicons.dev)

NOTE: This repo has switched to [conventional commits](https://www.conventionalcommits.org/en/v1.0.0). It requires `pre-commit` and `commitizen` to help with controlling this.  
```

```sh
# install pre-commmit (prerequisite for commitizen)
brew install pre-commit
brew install commitizen
# conventional commits extension
code --install-extension vivaxy.vscode-conventional-commits

# install hooks
pre-commit install --hook-type commit-msg --hook-type pre-push
```

## Adding LICENSE file

Click `Add File` button in `github` portal.  Type in name as `LICENSE` and choose the template you require.

## Adding CODEOWNERS

More info on [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)

```txt
*           @chrisguest75
.github/*   @chrisguest75
```

## Adding pipelines

Create a `./.github./workflows` folder

```sh
mkdir -p ./.github./workflows
```

## Adding branch protections

Use graphQL to create branch protections [docs](https://docs.github.com/en/graphql/reference/input-objects#createbranchprotectionruleinput)

```sh
export owner="chrisguest75"
export name="github-of-life"
repositoryId="$(gh api graphql -f query='{repository(owner:"'$owner'",name:"'$name'"){id}}' -q .data.repository.id)"
echo $repositoryId  

# -F for int 
# isAdminEnforced: false means I can override
gh api graphql -f query='mutation($repositoryId:ID!, $branch:String! $requiredReviews:Int!) {  
createBranchProtectionRule(input: {  
isAdminEnforced: false     
repositoryId: $repositoryId  
pattern: $branch  
requiresApprovingReviews: true  
requiredApprovingReviewCount: $requiredReviews 
 }) { clientMutationId }}' -f repositoryId="$repositoryId" -f branch="[main,master]*" -F requiredReviews=1
```

## Resources

* [issue 3528](https://github.com/cli/cli/issues/3528)
* [GraphQL explorer](https://docs.github.com/en/graphql/overview/explorer)
* [GraphQL](https://docs.github.com/en/graphql)
