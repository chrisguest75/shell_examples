# README
Demonstrate how to setup a cronjob

1) systemd?
1) MTA 

## Test Script
```sh
./public_ip.sh
cat /var/log/syslog
```

Use [crontab.guru](https://crontab.guru/every-1-minute) for easy ways to work out crontab format.

## Configure Cron Job (Debian)
Uncomment the log source for cron and restart services
```sh
nano /etc/rsyslog.d/50-default.conf
sudo service cron restart
sudo service rsyslog restart
```

Set up a basic frequent cron to test mechanism 
```sh
crontab -e
* * * * * $(pwd)/public_ip.sh
cat /var/log/cron.log
```

Then hourly on the hour
```sh
crontab -e
0 * * * * $(pwd)/public_ip.sh
cat /var/log/cron.log
```

## Remove the crontab entry
```sh
crontab -e
```

## Troubleshooting

```sh
# view the crontab
crontab -l

# look at the cron service
sudo systemctl status cron  

# rsyslog service
sudo systemctl status rsyslog     

man rsyslogd 
man cron
```