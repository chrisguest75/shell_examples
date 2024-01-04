# HOOKS

Examples relating to `git hooks`.  

Git hook scripts are useful for identifying simple issues before submission to code review. We run our hooks on every commit to automatically point out issues in code such as missing semicolons, trailing whitespace, and debug statements. By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.  

## Removing hooks

```sh
# listing hooks
ls -la $(git root)/.git/hooks

# delete all none sample hooks
find $(git root)/.git/hooks ! -name '*.sample' -print -delete 
```

## Pre-commit tool

```sh
brew install pre-commit
```

## Resources

* A framework for managing and maintaining multi-language pre-commit hooks. [here](https://pre-commit.com)  
* Supported hooks [here](https://pre-commit.com/hooks.html)  
