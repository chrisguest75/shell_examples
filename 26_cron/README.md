# README
Demonstrate how to setup a cronjob

1) systemd?

## Configure Cron Job (Debian)
Uncomment the log source for cron and restart services
```sh
nano /etc/rsyslog.d/50-default.conf
sudo service cron restart
sudo service rsyslog restart
```

Set up a basic frequent cron to tst mechanism 
```sh
crontab -e
*/2 * * * * $(pwd)/public_ip.sh
cat /var/log/cron.log
```

Then hourly
```sh
crontab -e
0 * * * * $(pwd)/public_ip.sh
cat /var/log/cron.log
```

