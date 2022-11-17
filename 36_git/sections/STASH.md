# README

Demonstrate how to use `stash`

## Common uses

### View stashes

```sh
# list the stashes
git stash list 

# show the patch diff of the stash
git stash show --patch 0
git stash show --patch 1

# show stashes with untracked files
git stash show -u --patch 0   
```

### Create stashes

```sh
# create stash
git stash 

# create single file stash 
git stash push -m "adding stash readme" 36_git/sections/STASH.md

# add unindexed file
git stash push -u -m "adding readme" 55_dotsourcing/README.md

# include untracked
git stash -u 
```

### Apply

```sh
# pop, apply and remove from list
git stash pop 0 

# apply and retain on list
git stash apply 0 
```

## Resources

* Git stash [here](https://www.atlassian.com/git/tutorials/saving-changes/git-stash)  
* Git-Tools-Stashing-and-Cleaning [here](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning)  
