# EXPLORING GITHUB

TODO:

* Find public repos without codeowners
* Clone add codeowners.  
* add branch protection for codeowners.
* Check license as well.

Ref: [NEW_REPOS.md](./NEW_REPOS.md)

## List repos

```sh
export PAGER=          

# list all repos 
gh repo ls --limit 150 --json name,isPrivate,isFork | jq . 

# filter non-forks and public
gh repo ls --limit 150 --json name,isPrivate,isFork | jq -r '.[] | select(.isFork == false and .isPrivate == false) | (.name)'
```

```sh
# find the default branch for this repo
gh api repos/chrisguest75/shell_examples | jq -r '.default_branch'
```

## Codeowners

```sh
# get codeowners errors
gh api repos/chrisguest75/shell_examples/codeowners/errors

# get file from repo (public only)
curl https://raw.githubusercontent.com/chrisguest75/github-of-life/main/CODEOWNERS
```

List if repo has a codeowners file or not  

```sh
GITHUBUSER=chrisguest75
while IFS='' read -r reponame 
do
    DEFAULT_BRANCH=$(gh api repos/${GITHUBUSER}/${reponame} | jq -r '.default_branch')
    CODEOWNERS="✅"
    ERRORS=$(gh api repos/${GITHUBUSER}/${reponame}/codeowners/errors) 2> /dev/null
    if [[ $? -ne 0 ]]; then
        CODEOWNERS="❌ \033[33merrors\033[0m"
    fi
    echo "${reponame}/${DEFAULT_BRANCH} ${CODEOWNERS}"
done < <(gh repo ls --limit 150 --json name,isPrivate,isFork | jq -r '.[] | select(.isFork == false and .isPrivate == false) | (.name)')
```

## Branches and protections

```sh
gh api 'repos/chrisguest75/github-of-life/branches' | jq '.[] | .name'

# branch protections
gh api 'repos/chrisguest75/github-of-life/branches?protected=false' 

gh pr --repo chrisguest75/shell_examples ls          
```

## Resources

* https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
* https://docs.github.com/en/rest/repos/repos#get-a-repository
