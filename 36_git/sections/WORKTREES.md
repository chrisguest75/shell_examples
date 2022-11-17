# WORKTREES

Examples relating to `git worktrees`.  

NOTE:

* It seems you can move from branch to branch in any of the worktrees but you can only ever have one checked out at a time.
* How do you find out where the parent .git folder is from a worktree?
  * There is a .git file in the worktree.  You can cat it to find the parent location
* How does stash relate to worktrees?  
  * The stash is related to the branch.

```sh
# list current worktrees
git worktree list 

# create a worktree (if local branch does not exist)
export BRANCH_NAME=vim
git worktree add -b $BRANCH_NAME $(git root)/../shell_examples_wt_$BRANCH_NAME origin/$BRANCH_NAME

# if local branch already exists
export BRANCH_NAME=vim
git worktree add $(git root)/../shell_examples_wt_$BRANCH_NAME $BRANCH_NAME

# switch to the directory
pushd $(git root)/../shell_examples_wt_$BRANCH_NAME

# list my folders 
ls -la $(git root)/../

# worktree .git is now a file
cat $(git root)/../shell_examples_wt_$BRANCH_NAME/.git

# open up in code.
code $(git root)/../shell_examples_wt_$BRANCH_NAME

# remove the worktree
rm -rf $(git root)/../shell_examples_wt_$BRANCH_NAME

# list prunable (after deleting)
git worktree list 

# prune it.
git worktree prune
```

## Resources  

* git-worktree - Manage multiple working trees [here](https://git-scm.com/docs/git-worktree)  
