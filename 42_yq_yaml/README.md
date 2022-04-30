# README

Demonstrates some examples of using `yq` to process yaml files

## Preeqs

```sh
brew info yq

brew install yq

# using version 4.25.1 at time of writing
yq --version 
```

## Simple

```sh
# read and process
yq eval ./examples/simple.yaml 

# render with debugging 
yq eval -v ./examples/simple.yaml   

# extract a field
yq eval .image ./examples/simple.yaml 
```

## Anchors

```sh
# show internal representation of yaml
yq eval ./examples/anchors.yaml

# playing with anchors
yq '. | explode(.)' ./examples/anchors.yaml  
```

## Merging

```sh
yq '. *= load("./examples/simple.yaml")' ./examples/anchors.yaml
```

## Validation

```sh
yq -P ./examples/broken.yaml                
```

## Resources

* mikefarah/yq repo [here](https://github.com/mikefarah/yq)
* How It Works [here](https://mikefarah.gitbook.io/yq/how-it-works)
* Anchor and Alias Operators [here](https://mikefarah.gitbook.io/yq/operators/anchor-and-alias-operators)
* Multiply (Merge) [here](https://mikefarah.gitbook.io/yq/operators/multiply-merge)
* The yq gitbook has lots of good examples [here](https://mikefarah.gitbook.io/yq/upgrading-from-v3)
* yq: Mastering YAML Processing in Command Line [here](https://towardsdatascience.com/yq-mastering-yaml-processing-in-command-line-e1ff5ebc0823)
