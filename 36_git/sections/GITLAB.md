# GITLAB

Show some `gitlab` features.  

## Push Options

Push options allow you to send commands to the server. These allow you to create PRs or Skip CI.  

```sh
git push -o merge_request.create -o merge_request.title "My MR" -o merge_request.description "My MR description"
```

## Resources

* Push options [here](https://docs.gitlab.com/ee/user/project/push_options.html)  
