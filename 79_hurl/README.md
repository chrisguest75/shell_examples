# HURL

Use hurl to test an API.  

TODO:

* Is there a way to introduce delays in chained requests?  
* Exporting captured values to environment variables

NOTES:

* support variable when sourcing payload from file [BUG 1731](https://github.com/Orange-OpenSource/hurl/issues/1731)

## Install

```sh
# using 4.3.0
brew install hurl

hurl --help
```

## Examples

First you'll need to create the `hurl.vars` file from the template.  

### Google

```sh
mkdir -p ./out
hurl --very-verbose --test google.hurl 
```

### Upload

```sh
# Start an upload.  
export HURL_VARS_FILE=./vars/hurl.vars

hurl --very-verbose --test trint-upload.hurl  --variables-file $HURL_VARS_FILE --file-root $(pwd)/media
```

### Run realtime scripts

```sh
# Start a realtime.  
export HURL_VARS_FILE=./vars/hurl.vars
hurl --very-verbose --test trint-realtime.hurl --variables-file $HURL_VARS_FILE

# start 
hurl --very-verbose --test trint-realtime-start.hurl --variables-file $HURL_VARS_FILE

# find the trintid in the above output
hurl --very-verbose --test trint-realtime-status.hurl --variables-file $HURL_VARS_FILE --variable trintid=SwwPSV7NQS6IHtB7PHGxNQ

# now stop it
hurl --very-verbose --test trint-realtime-stop.hurl --variables-file $HURL_VARS_FILE --variable trintid=SwwPSV7NQS6IHtB7PHGxNQ
```

## Resources

* [hurl.dev](https://hurl.dev/)  
* Orange-OpenSource/hurl repo [here](https://github.com/Orange-OpenSource/hurl)  
* The Trint API Developer Hub [here](https://dev.trint.com/)  
