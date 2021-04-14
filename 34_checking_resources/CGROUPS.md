https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-i-linux-control-groups-and-process

https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-ii-working-linux-containers-lxc


SSH in a cgroup
https://unix.stackexchange.com/questions/209199/how-to-ensure-ssh-via-cgroups-on-centos

https://unix.stackexchange.com/questions/56538/controlling-priority-of-applications-using-cgroups

cgroupsv2
https://unix.stackexchange.com/questions/471476/how-do-i-check-cgroup-v2-is-installed-on-my-machine

## Limits
docker run -it ubuntu:20.04 /bin/bash -c "ulimit -a" 

ulimit -a 

cat /proc/$$/limits 

## Cgroups 
```sh
cat /proc/filesystems  
mount
```

```sh
ls /sys/fs/cgroup/
```

