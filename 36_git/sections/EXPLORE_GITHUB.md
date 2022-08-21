# EXPLORING GITHUB

TODO:

* Find public repos without codeowners
* Clone add codeowners.  
* add branch protection for codeowners.
* Check license as well.



```sh
gh repo ls --limit 150 --json name,isPrivate,isFork | jq . 
gh repo ls --limit 150 --json name,isPrivate,isFork | jq -r '.[] | select(.isFork == false and .isPrivate == false) | (.name)'

gh api repos/chrisguest75/shell_examples | jq -r '.default_branch'
gh api repos/chrisguest75/github-of-life | jq -r '.default_branch'

```


```sh
export PAGER=          
gh api repos/chrisguest75/shell_examples/codeowners/errors
gh api repos/chrisguest75/github-of-life/codeowners/errors 
```

https://raw.githubusercontent.com/chrsiguest75/shell-examples/master/CODEOWNERS
https://raw.githubusercontent.com/chrsiguest75/github-of-life/main/CODEOWNERS


```sh
GITHUBUSER=chrisguest75
while IFS='' read -r reponame 
do
    DEFAULT_BRANCH=$(gh api repos/${GITHUBUSER}/${reponame} | jq -r '.default_branch')
    CODEOWNERS="no errors\033[48;2;0;255;0m "
    ERRORS=$(gh api repos/${GITHUBUSER}/${reponame}/codeowners/errors) 2> /dev/null
    if [[ $? -ne 0 ]]; then
        CODEOWNERS="errors\033[48;2;255;0;0m "
    fi
    echo "REPO ${reponame}/${DEFAULT_BRANCH} ${CODEOWNERS}"
done < <(gh repo ls --limit 150 --json name,isPrivate,isFork | jq -r '.[] | select(.isFork == false and .isPrivate == false) | (.name)')
```


## Resources

https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
https://docs.github.com/en/rest/repos/repos#get-a-repository
