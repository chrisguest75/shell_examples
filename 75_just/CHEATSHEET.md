# JUST CHEATSHEET

```sh
# show internal variables
just -f example.justfile --variables

# render the variables. 
just -f example.justfile --evaluate

# override defaults
just DOCKER_BUILD_ARGUMENTS="--no-cache" REQUIREMENTS_CATEGORY="dev-packages" start_image slim
```

## Resources
