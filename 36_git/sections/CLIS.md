# GIT CLIS

Github and Gitlab both have cli tooling for working with PR/MR and issues, etc.  

## Github CLI

### How do I work with PRs on a repo from cli?

Using the github cli command.  

```sh
# turn off pager 
PAGER= 

# list PRs using github cli
gh pr list

# create a draft pr
gh pr create --draft

# look at changes in PR. 
gh pr diff <id>

# you can edit the title of the pr
gh pr edit <id>

# promote a draft pr to ready
gh pr ready <id>

# merge to master
gh pr commit <id>
gh pr merge <id>
```

## Gitlab CLI

Use the gitlab cli command.  

```sh
# list mr
glab mr list

# create an mr
glab mr create

# view gitlab in browser 
glab repo view --web
```

## Resources

* Gitlab cli [glab](https://glab.readthedocs.io/en/latest/)  
* [glab source](https://github.com/profclems/glab)
