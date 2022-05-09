# SEARCHING

Demonstrate some examples of searching for commits.  

```sh
# search for author
git log --author "Chris Guest" 

# find mentions of configuration
git log -S "configuration" -p | grep configuration

# find mentions of cheatsheet by author
git log --author "Chris Guest" -S "cheatsheet" -p
```
