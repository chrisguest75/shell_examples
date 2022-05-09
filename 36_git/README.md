# README

Demonstrates some examples of using `git` queries and tools  

TODO:

* Gitlab cli [glab](https://glab.readthedocs.io/en/latest/)  
* [glab source](https://github.com/profclems/glab)
* Deleting branches
* git filter-repo
* git reset --hard origin/feature reset against a new pushed version of a branch.
* .gitattributes https://git-scm.com/docs/gitattributes

## Files

* FAQS - [FAQS.md](./sections/FAQS.md)  
* Squashing Walkthrough - [SQUASHING_WALKTHROUGH.md](./sections/SQUASHING_WALKTHROUGH.md)  
* Reverting Walkthrough - [REVERTING_WALKTHROUGH.md](./sections/REVERTING_WALKTHROUGH.md)  
* Creating new repos - [NEW_REPOS.md](./sections/NEW_REPOS.md)  
* Patching - [PATCHING.md](./sections/PATCHING.md)  
* Hooks - [HOOKS.md](./sections/HOOKS.md)  
* Worktrees - [WORKTREES.md](./sections/WORKTREES.md)  
* Searching - [SEARCHING.md](./sections/SEARCHING.md)  
* Git Crypt - [GIT_CRYPT.md](./sections/GIT_CRYPT.md)  
* Helper Scripts - [HELPER_SCRIPTS.md](./sections/HELPER_SCRIPTS.md)  

## Upgrade

```sh
# see latest version of git
brew info git

# take latest version
brew upgrade git
```

## Git Extras

Git extras are a set of helpers for git.

MacOS  

```sh
# see latest version of git-extras
brew info git-extras

# macosx extras and gh cli
brew install git-extras

# github cli
brew install gh

# gitlab cli
brew install glab  
```

Linux  
[brew.sh](https://docs.brew.sh) required for gh on ubuntu/debian [linuxbrew](https://docs.brew.sh/Homebrew-on-Linux)  

```sh
# debian
apt install git-extras
```

## Open repo in code

```sh
# sometimes you might be in a subdirectory in the repo
code $(git root)
```

## Examining repos

```sh
# Files changed since yesterday on current branch.
git effort -- --since='yesterday'
git effort -- --since='1 month ago'
```

### Check tag format

```sh
git check-ref-format "tags/0.0.1-a39f8a821fc9" 
```

## Resources

* [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md) are a really good set of useful supplementary commands.  
* [github cli](https://github.com/cli/cli) tool that supports creating PRs directly from the shell  
* Git Release Notes [here](https://github.com/git/git/tree/master/Documentation/RelNotes)  
* Git blog from github [here](https://github.blog/tag/git/)  
