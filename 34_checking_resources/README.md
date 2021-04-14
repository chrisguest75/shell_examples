# Checking Resources 
Demonstrate how to use various commands to verify resource usage in the OS.


TODO:
* Open sockets
* Free memory 
* File handles
* Look at the brenden gregg resources http://www.brendangregg.com/linuxperf.html
* Filesystem
* Procfs
* debugfs
https://github.com/raboof/nethogs

## Check limits
```sh
ulimit -a
```
## Disk

```sh
# free space
df -h
```

## Sockets

```sh
# summary of all the sockets
ss -s 

# listening sockets
ss -l 

# listening sockets with processes
sudo ss -lp

# tcp connections with information
ss -ti 
```


## Memory

```sh
free -h

vmstat 
```

## IO

[sysstat](https://www.linux.com/training-tutorials/sysstat-howto-deployment-and-configuration-guide-linux-servers/)  

```sh

sudo apt install sysstat   

# cpu usage
mpstat -A



```



top
systemd-cgtop   
systemd-analyze blame 

systemctl list-units -t service        

