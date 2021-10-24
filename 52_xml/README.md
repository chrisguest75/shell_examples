# README
Demonstrate how to handle Xml in shell scripts. 

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


# Resources 
* Some example Xml tooling [here](https://stackoverflow.com/questions/15461737/how-to-execute-xpath-one-liners-from-shell/15461774)
* Explanation of the namespacing issues [here](https://stackoverflow.com/questions/8264134/xmllint-failing-to-properly-query-with-xpath)
* More namespacing [here](http://blog.powered-up-games.com/wordpress/archives/70)
* https://danielmiessler.com/blog/extract-xml-elements-using-xmllint/


