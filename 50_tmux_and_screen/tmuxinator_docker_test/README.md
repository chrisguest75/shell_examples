# TMUXINATOR DOCKER TEST

Test tmuxinator building and showing logs from a container.  

* Build a docker container
* Run the docker container
* Get logs in the bottom window

TODO:

* Build the container, run and get the logs.  
* Split the windows in the correct direction.
* Wondering if it's best to mix with just to control what gets run in each pane.  

## Run

Use the [07_detect_os/README.md](../../07_detect_os/README.md) as an example.  

```sh
cd 50_tmux_and_screen/tmuxinator_docker_test
tmuxinator

ctrl+b d

tmux kill-session -t docker_test
```

## Creation

```sh
tmuxinator new --local docker_test

# use just
just start-tmux
```

## Kill window

`ctrl+b + &` Kill Window


```