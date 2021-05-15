# README
Demonstrate a way to produce ENV overrides in a CI pipeline

## Example
Sometimes in CI pipelines we wish to be able to control behaviour in specific branch builds or on reruns of specific commits.  

This technique will override global environment varibles with the vakues of prefixed environment variables.  

```sh
# run the script (it dotsources ci_env)
./pretend_run_master.sh
# passed in a branch name it will resolve and overwrite global env vars.
./pretend_run_master.sh chris_branch fb93e86f557c95d86e5dfc84973661183be8c5fa
```

By prefixing environment variables with branch or commitsha ids we can override parameters. 
```sh
chris_branch_TF_LOG=DEBUG
```
