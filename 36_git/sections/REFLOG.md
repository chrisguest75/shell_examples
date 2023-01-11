# REFLOG

Examples relating to `git reflog`.  

NOTES:

* reflog seems to be a local log. It is clear on a clone.
* You can see the commits that you may have cleared with a `git reset head~4`  
* You can `git show commitsid` the reflog and cherry pick them into other branches.  

```sh
git reflog
```

## Resources

* How to undo (almost) anything with Git [here](https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/)  
* git reflog [here](https://www.atlassian.com/git/tutorials/rewriting-history/git-reflog)  
