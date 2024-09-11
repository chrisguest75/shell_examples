# README

Demonstrate a simple `zsh` container using features.  

Demonstrates:

* Using features
* It seems to be much quicker to build.  

TODO:

* Configure zsh correctly (niceprompt).  

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [Start (vscode)](#start-vscode)
  - [Run tests](#run-tests)
  - [Stop](#stop)
  - [Resources](#resources)

## Start (vscode)

Use the Remote Containers extension and select "Reopen in Container" or...  

```sh
# start devcontainer
./devcontainerctl.sh -n=07_oh_my_zsh

# start devcontainer (rebuild)
./devcontainerctl.sh -n=07_oh_my_zsh --no-cache
```

Use `⌘ + ^ + p` and "Dev Containers: Attach to a running container"

Add `/workspaces/devcontainer_examples` as a workspace to the new vscode editor.  

```sh
cd /workspaces/devcontainer_examples
```

## Run tests

```sh
cd ./07_oh_my_zsh
echo $DEVCONTAINER_TYPE
```

## Stop

```sh
# stop devcontainer
./devcontainerctl.sh -n=07_oh_my_zsh --down
```

## Resources

* devcontainers/cli repo [here](https://github.com/devcontainers/cli)  
* devcontainers-contrib/features repo [here](https://github.com/devcontainers-contrib/features)
* codespaces-multi-repository-monorepo-scenarios blog [here](https://github.blog/2022-04-20-codespaces-multi-repository-monorepo-scenarios/)  
* integrated-terminal config [here](https://code.visualstudio.com/docs/editor/integrated-terminal)  
