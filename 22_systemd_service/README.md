# README
Install a basic systemd service

## Configure


ExecStart=/usr/bin/env bash -c /home/chrisguest/Code/shell_examples/22_systemd_service/webservice.sh 8081 "Hello from systemd"
User=$(whoami)


```sh
# install the service
sudo ln -s $(pwd)/chrisguest75webservice.service /etc/systemd/system/chrisguest75webservice.service  
```

```sh
# remove the service
sudo rm /etc/systemd/system/chrisguest75webservice.service  
```


systemctl start chrisguest75webservice 

systemctl status chrisguest75webservice 

curl -vvvv localhost:8081/clientpath  

systemctl stop chrisguest75webservice 
