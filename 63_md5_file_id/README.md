# README

Demonstrate how to id files using `md5sum`

TODO:

* How to verify a download

## Help

```sh
# bsd version
md5sum --version
md5sum --help

# from coreutils
gmd5sum --version
gmd5sum --help
```

## Calculate hash only

```sh
file ./README.md  
md5sum ./README.md | tr " " "\n" | head -n 1   
```

## Create md5 values

```sh
find . -maxdepth 1 -type f -exec md5sum {} \; 
```

## Generate json document for md5

```sh
TEMPFILE=$(mktemp)
find .. -maxdepth 2 -type f -exec md5sum {} \; > ${TEMPFILE}
echo '{ "files":[] }' > ./md5s.json
while IFS=" " read -r md5value filepath
do
    size=$(gstat --printf="%s" ${filepath})
    echo "md5value:${md5value} filepath:${filepath} size:${size}"

    jq --arg md5value "${md5value}" --arg size "${size}" --arg filepath "${filepath}" '.files += [{md5: $md5value, filepath: $filepath, size: $size}]' ./md5s.json > ./out_md5s.json
    mv ./out_md5s.json ./md5s.json
done < <(cat ${TEMPFILE})
```

## Resources

* Only get hash value using md5sum (without filename) [here](https://stackoverflow.com/questions/3679296/only-get-hash-value-using-md5sum-without-filename)
