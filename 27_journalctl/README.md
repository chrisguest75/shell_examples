# README

```sh
journalctl --disk-usage  
cat /etc/systemd/journald.conf 
```

# view errors
journalctl -p 3  

# list the boots 
journalctl --list-boots    
# start with logs at specific time
journalctl -b 0 


journalctl --no-pager  
journalctl -b -u containerd.service    