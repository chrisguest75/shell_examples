# README

Demonstrate how to handle Xml in shell scripts.

## Install

```sh
# install xmllint package
sudo apt install libxml2-utils
```

## Troubleshooting

```sh
xmllint --debug ./danceloop_00009.svg 
```

## Shell

Manually find the correct paths

```sh
xmllint --shell ./danceloop_00009.svg 

> help
> setns x=http://www.w3.org/2000/svg
> xpath /x:svg/x:g
> xpath /x:svg/x:g/x:path/@d
```

## Extraction

```sh
# this fails because svg is namespaced
xmllint --xpath '//svg/g/path/@d' ./52_xml/danceloop_00009.svg

# loosens the path selection
xmllint --debug --xpath "//*[local-name()='path']" ./danceloop_00009.svg

# extract the attribute
xmllint --debug --xpath "string(//*[local-name()='path']/@d)" ./danceloop_00009.svg
```

## Convert into JSON

Refer to the [jq examples](../32_jq/README.md)

```sh
cat <<- EOF > "./frames.json"
{
    "frames": [
    ]
}
EOF
_filename="./danceloop_00009.svg"
_no_extension="${_filename%.*}"
_frame_number=$(echo ${_no_extension} | grep --color=never -o -E '[0-9]+')
xmllint --debug --xpath "string(//*[local-name()='path']/@d)" ./danceloop_00009.svg > /path.txt
jq --rawfile path ./path.txt --arg filename "${_no_extension}" --arg number "${_frame_number}" '.frames += [ {"name":$filename, "path":$path, "number":$number | tonumber }]' "./frames.json"
```

## Process NMAP

Ref: [11_nmap_scanning](https://github.com/chrisguest75/sysadmin_examples/tree/master/11_nmap_scanning)  

```sh
# scan network (save xml file)
nmap -p 22 -oX ./net.xml -vvv 192.168.1.0/24   

# show hosts that are up
xmllint --xpath '//host/status[@state="up"]/../address/@addr' ./net.xml
```

## RSS Feed

```sh
mkdir -p ./out

# get rss feed
curl -s -o ./out/rss.xml https://latenightlinux.com/feed/mp3

# get first url
FEED_URL=$(xmllint --xpath 'string(//rss/channel/item[1]/enclosure/@url)' --format --pretty 2 ./out/rss.xml)

# get the file
curl -s -L -o ./out/$(basename $FEED_URL) $FEED_URL
```

## Resources

* Some example Xml tooling [here](https://stackoverflow.com/questions/15461737/how-to-execute-xpath-one-liners-from-shell/15461774)
* Explanation of the namespacing issues [here](https://stackoverflow.com/questions/8264134/xmllint-failing-to-properly-query-with-xpath)
* More namespacing [here](http://blog.powered-up-games.com/wordpress/archives/70)
* Extract XML Elements Using xmllint [here](https://danielmiessler.com/blog/)extract-xml-elements-using-xmllint/
* xmllint in Linux [here](https://www.baeldung.com/linux/xmllint)  
* xpath cheatsheet [here](https://devhints.io/xpath)
* What is RSS? [here](https://validator.w3.org/feed/docs/rss2.html)