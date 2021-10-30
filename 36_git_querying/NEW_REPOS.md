# Configuration for new repos
When configuring a new repo consider the following.  
## Adding LICENSE file
Click `Add File` button in `github` portal.  Type in name as `LICENSE` and choose the template you require.
## Adding CODEOWNERS
More info on [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)

```txt
@chrisguest75
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
gh api graphql -f query='mutation($repositoryId:ID!, $branch:String! $requiredReviews:Int!) {  
createBranchProtectionRule(input: {  
isAdminEnforced: true     
repositoryId: $repositoryId  
pattern: $branch  
requiresApprovingReviews: true  
requiredApprovingReviewCount: $requiredReviews 
 }) { clientMutationId }}' -f repositoryId="$repositoryId" -f branch="[main,master]*" -F requiredReviews=1
```

# Resources 
* [issue 3528](https://github.com/cli/cli/issues/3528)
* [GraphQL explorer](https://docs.github.com/en/graphql/overview/explorer)
* [GraphQL](https://docs.github.com/en/graphql)
