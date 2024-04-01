# FIXING HISTORY

Demonstrate some simple commands useful to fixing history in a branch.  

TODO: 

* Work out how to use Fixup

## Reason

If you have long term PRs that you occasionally come back to fix up and merge. You may experience problems if you've added `conventional-commits` or `husky` to the repo. Meaning a rebase with force push it might fail.  

## Rewrite

NOTE: To amend the title you can use `reword`.  

```sh
# look at the history
git log --oneline --graph -n 10

# find the merge base
git merge-base head~1 master

# use the commitid in an interactive rebase
git rebase -i 32cbeee2bc4b9fc502e1ec9c217326a83ee536e3..head

# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
#         create a merge commit using the original merge commit's
#         message (or the oneline, if no original merge commit was
#         specified); use -c <commit> to reword the commit message
# u, update-ref <ref> = track a placeholder for the <ref> to be updated
#                       to this position in the new commits. The <ref> is
#                       updated at the end of the rebase
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
```

## Resources

* GIT tip : Keep your branch clean with fixup and autosquash [here](https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html)
* GIT - The power of fixup & autosquash [here](https://congtuanle.medium.com/git-the-power-of-fixup-autosquash-f1c91f7d962b)
* Smoother rebases with auto-squashing Git commits [here](https://andrewlock.net/smoother-rebases-with-auto-squashing-git-commits/)  
