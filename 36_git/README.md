# README

Demonstrates some examples of using `git` queries and tools  

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [Sections](#sections)
  - [Installing a new machine](#installing-a-new-machine)
  - [Upgrade](#upgrade)
  - [Git Extras](#git-extras)
  - [Open repo in code](#open-repo-in-code)
  - [Examining repos](#examining-repos)
  - [Clean](#clean)
  - [Resources](#resources)

TODO:

* Deleting branches
* git filter-repo - https://github.com/newren/git-filter-repo
* git reset --hard origin/feature reset against a new pushed version of a branch.
* .gitattributes https://git-scm.com/docs/gitattributes
* git update-index --assume-unchanged sites/default/settings.php
* git check-ignore vscode/list_extensions.sh  
* git bisect example
* https://git-scm.com/docs/git-notes
* Do some tests on HEAD.  git log HEAD -n 1, git log origin/HEAD -n 1. Fixing `git log origin/HEAD..HEAD -n 1` missing `git remote set-head origin -a` https://learnku.com/articles/71493

## Sections

* FAQS - [FAQS.md](./sections/FAQS.md)  
* Rebasing fun - [REBASING_FUN.md](./sections/REBASING_FUN.md)  
* Squashing Walkthrough - [SQUASHING_WALKTHROUGH.md](./sections/SQUASHING_WALKTHROUGH.md)  
* Reverting and Rollback Walkthrough - [ROLLBACK_WALKTHROUGH.md](./sections/ROLLBACK_WALKTHROUGH.md)  
* Creating new repos - [NEW_REPOS.md](./sections/NEW_REPOS.md)  
* Patching - [PATCHING.md](./sections/PATCHING.md)  
* Hooks - [HOOKS.md](./sections/HOOKS.md)  
* Worktrees - [WORKTREES.md](./sections/WORKTREES.md)  
* Stashing - [STASH.md](./sections/STASH.md)  
* Searching - [SEARCHING.md](./sections/SEARCHING.md)  
* Git Crypt - [GIT_CRYPT.md](./sections/GIT_CRYPT.md)  
* Helper Scripts - [HELPER_SCRIPTS.md](./sections/HELPER_SCRIPTS.md)  

## Installing a new machine

Goto [chrisguest75/sysadmin_examples08_ssh/README.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/08_ssh/README.md#generate-keys) to show how to generate keys.  

```sh
git config --local user.email "chrisguest75@users.noreply.github.com"
git config --local user.name "Chris Guest"
```

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
# count number of commits
git rev-list HEAD --count

# Files changed since yesterday on current branch.
git effort -- --since='yesterday'
git effort -- --since='1 month ago'
```

## Clean

To restore a repo to a fresh clone.  

```sh
# -x Don’t use the standard ignore rules
# -d Specify -d to have it recurse into such directories
# -f Force
git clean -xfd
```

## Resources

* Git --fast-version-control [here](https://git-scm.com/)
* [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md) are a really good set of useful supplementary commands.  
* [github cli](https://github.com/cli/cli) tool that supports creating PRs directly from the shell  
* Git Release Notes [here](https://github.com/git/git/tree/master/Documentation/RelNotes)  
* Git blog from github [here](https://github.blog/tag/git/)  
* Git Rev News [here](https://git.github.io/rev_news/)
* Learn Git Branching [here](https://learngitbranching.js.org/)
