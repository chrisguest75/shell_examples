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

## Disk

```sh
# free space
df -h
```

## Sockets

```sh
# listening sockets
ss -l 
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

