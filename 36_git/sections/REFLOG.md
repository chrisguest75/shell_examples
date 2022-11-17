# REFLOG

Examples relating to `git reflog`.  

NOTES:

* reflog seems to be a local log. It is clear on a clone.
* You can see the commits that you may have cleared with a `git reset head~4`  
* You can `git show commitsid` the reflog and most likely cherry pick them into other branches.  

```sh
git reflog
```