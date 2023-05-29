# DOWNLOAD RELEASES

Downloading releases from Github.  

## Github CLI

It's possible to do this in the `gh` cli now.  

```sh
# list releases 
gh release list -R containerd/stargz-snapshotter

# download
gh release download v0.14.3 -R containerd/stargz-snapshotter
```

## CURL

Releases can be found on the github repo page and the link address can be copied. Curl needs to be instructed to follow redirects though.  

```sh
curl -Lo stargz-snapshotter-v0.14.3-linux-amd64.tar.gz https://github.com/containerd/stargz-snapshotter/releases/download/v0.14.3/stargz-snapshotter-v0.14.3-linux-amd64.tar.gz 
```

## Resources

* An example gist [here](https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8)  
