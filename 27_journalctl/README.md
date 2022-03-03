# README

Demonstrate how to use journalctl to discover logs

## Existing logs

```sh
# lastlog - reports the most recent login of all users or of a given user
lastlog

# syslog 
cat /var/log/syslog
# kernel log
cat /var/log/kern.log
# 
dmesg
```

```sh
# remove the logs 
sudo dmesg --clear
```

## Configuration and space

```sh
# look at the diskspace the logs are taking.
journalctl --disk-usage  
# configuration
cat /etc/systemd/journald.conf 
```

## Loglevels -p <level>

From the syslog protocol [RFC 5424](https://tools.ietf.org/html/rfc5424)

```sh
  # RFC 5424
  #
  # Numerical         Severity
  #   Code
  #
  #    0       Emergency: system is unusable
  #    1       Alert: action must be taken immediately
  #    2       Critical: critical conditions
  #    3       Error: error conditions
  #    4       Warning: warning conditions
  #    5       Notice: normal but significant condition
  #    6       Informational: informational messages
  #    7       Debug: debug-level messages
```

## Logs for boots

```sh
# view errors since last boot
journalctl -b 0 -p 3 --no-pager

# list the boots 
journalctl --list-boots

# start with logs at specific boot
journalctl -b 0 
```

## Logs for services

```sh
# find a service and get the logs for it.
systemctl list-unit-files "*.service" 
systemctl list-units --type=service --no-pager         

journalctl -b -u [servicename].service --no-pager  

# output the logs as json
journalctl -u [servicename].service --no-pager --output=json
```

## Logs for kernel (including ufw)

```sh
journalctl -b 0 -k -p 4 
```

## Why are logs for apt and dpkg not in journald?

I'm not sure why dpkg does not use systemd and journald logging/

```sh
# dpkg logs
cat /var/log/dpkg.log   
```

## Maintenance

```sh
# validate the logs
journalctl --verify

# shrink the size
sudo journalctl --vacuum-size=10M
```

## Resources

* Journalctl usage [here](https://www.debugpoint.com/2020/12/systemd-journalctl/)  
* Cleaning up logs [here](https://www.debugpoint.com/2021/01/systemd-journald-clean/)
