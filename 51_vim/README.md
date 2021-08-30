# README.md
Demonstrates configuring a container for `vim`

Based on `nice prompt` example [here](https://github.com/chrisguest75/docker_build_examples/tree/master/21_nice_prompt) 

## Build
```sh
# build and run
docker build -f Dockerfile.alpine -t vimcontainer . 
docker run --rm -it -d --name vimcontainer vimcontainer
```
## Running

```sh
docker exec -it vimcontainer /bin/zsh   
# or 
docker exec -it vimcontainer /bin/bash   
```

## Examples

```sh
vim --version

tmux

vim 
:PlugInstall
```


## Cleanup
```sh
# cleanup the container
docker stop vimcontainer 
```


# Resources 
* oh-my-zsh [here](https://ohmyz.sh/#install)  
* oh-my-bash [here](https://github.com/ohmybash/oh-my-bash)  
* locales [here](http://jaredmarkell.com/docker-and-locales/)

https://github.com/chrisguest75/default_dotfiles
https://github.com/junegunn/vim-plug
https://github.com/junegunn/vim-plug/wiki/tutorial

https://vimawesome.com/


https://vimawesome.com/plugin/nerdtree-red

https://github.com/JAremko/alpine-vim

https://github.com/amix/vimrc


