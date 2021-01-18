# README
Install a basic systemd service

TODO:
* Add an apt installer with manpage.
* Journalctl logs 
## Configure
```sh
# generate config from shell variables $USER and $PWD
cat ./chrisguest75webservice.service.template | envsubst > ./chrisguest75webservice.service 
```

## Install
```sh
# install the service
sudo ln -s $(pwd)/chrisguest75webservice.service /etc/systemd/system/chrisguest75webservice.service  

# Start the service
sudo systemctl start chrisguest75webservice 

systemctl status chrisguest75webservice 
```

## Test 

```sh
# test the webservice
curl -vvvv localhost:8081/clientpath  
```

## Remove

```sh
# stop the service
systemctl stop chrisguest75webservice 
```

```sh
# remove the service
sudo rm /etc/systemd/system/chrisguest75webservice.service  
```
