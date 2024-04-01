# CHARACTER ENCODINGS

Demonstrate ways of working with character encodings.  

REF: [62_binary_files/README.md](../62_binary_files/README.md)  
REF: [72_line_endings/README.md](../72_line_endings/README.md)  

## Detection

```sh
# identify file encoding
file ./utf8_1.txt 
> ./utf8.txt: Unicode text, UTF-8 text

# no BOM is visible
xxd ./utf8_1.txt | more
```

## Conversion

iconv - convert text from one character encoding to another

```sh
# types of encoding available
iconv --list

mkdir -p ./out

# -c skip conversion errors 
iconv -f UTF-8 -c -t ASCII utf8_1.txt > ./out/ascii-fromUTF8.strings

# NOTE: these output files do not load in VScode
iconv -f UTF-8 -t UTF-16LE utf8_1.txt > ./out/b-16le-fromUTF8.strings
iconv -f UTF-8 -t UTF-16BE utf8_1.txt > ./out/b-16be-fromUTF8.strings

xxd ./out/b-16be-fromUTF8.strings | more
```

## Resources

### Reference

* HTML Unicode (UTF-8) Reference [here](https://www.w3schools.com/charsets/ref_html_utf8.asp)
* Byte order mark [here](https://en.wikipedia.org/wiki/Byte_order_mark#UTF-8)
* How can you tell if a file is UTF-8 encoded or not? [here](https://chainsawonatireswing.com/2012/04/22/how-can-you-tell-if-a-file-is-utf-8-encoded-or-not/)
* Unicode Technical Quick Start Guide [here](https://home.unicode.org/technical-quick-start-guide/)

### Examples

* UTF-8 encoded sample plain-text file [here](https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt)
* Another UTF-8 encoded sample plain-text file [here](https://antofthy.gitlab.io/info/data/utf8-demo.txt)
* https://github.com/bits/UTF-8-Unicode-Test-Documents

### Fonts

* Noto: A typeface for the world [here](https://fonts.google.com/noto)

### Diacritics

* d͚͚͚̊̊̊i͚͚̥͚̊ḁ͚͚̥̥c͚̥̥̥̥̊̊̊r̥͚̥͚̥i͚̥̥̥͚̊̊̊̊t̥͚͚̊̊̊i͚̥͚̊̊̊c͚̥͚̊̊i̥͚̥͚̊̊̊̊̊s͚̥̊̊̊m͚͚̥̊̊̊ [here](http://demo.danielmclaren.com/2015/diacriticism/)
* Weird Text Generator [here](https://lingojam.com/WeirdTextGenerator) 
