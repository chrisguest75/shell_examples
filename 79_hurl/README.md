# HURL

Use hurl to test an API.  

TODO:

* Is there a way to introduce delays in chained requests?  
* Exporting captured values to environment variables

## Install

```sh
brew install hurl

hurl --help
```

## Run scripts

First you'll need to create the `hurl.vars` file from the template.  

```sh
# Start a realtime.   
hurl --very-verbose --test trint-realtime.hurl --variables-file ./hurl.vars


# start 
hurl --very-verbose --test trint-realtime-start.hurl --variables-file ./hurl.vars
# find the trintid in the above output
hurl --very-verbose --test trint-realtime-status.hurl --variables-file ./hurl.vars --variable trintid=AIn0AosISr2G3u0gY-eP6Q 
# now stop it
hurl --very-verbose --test trint-realtime-stop.hurl --variables-file ./hurl.vars --variable trintid=AIn0AosISr2G3u0gY-eP6Q 
```

## Resources

* [hurl.dev](https://hurl.dev/)  
* Orange-OpenSource/hurl repo [here](https://github.com/Orange-OpenSource/hurl)  
* The Trint API Developer Hub [here](https://dev.trint.com/)  
