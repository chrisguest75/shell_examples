# README

Demonstrate how to parse and work with CSV files

TODO:

- Fix the empty string handling
- Validate data being piped
- tidy viewer - https://github.com/alexhallam/tv

NOTES:

- Use `mechatroner.rainbow-csv` in vscode. You can also use it to align fields.

## Example

Show how to read a csv file and loop over it row by row.

```sh
./parse_csv.sh
```

## Conversion

### CSV 2 JSON

An example script to take a csv data piped in and convert it into a json document.

```sh
# simple example using jq to create a json doc
cat ./test.map | ./csv2json.sh
```

### TSV 2 CSV

Convert a TSV to CSV

```sh
tr '\t' ',' < ./file.tsv > ./file.csv
```

## Generate CSV from CPU data

```sh
echo "time,cpu,pid,process" > ./cpu.csv
for index in $(seq 0 100 );
do
    ps -opcpu -opid -ocomm -cax | grep -i windowserver | sort -r | sed "s/^/$(date '+%H:%M:%S') /" | sed 's/\t/ /g' | sed 's/  */ /g' | sed 's/ /,/g'
    sleep 1
done >> ./cpu.csv

sqlite3 :memory: -cmd '.mode csv' -cmd '.import cpu.csv cpu' 'SELECT time, COUNT(*), AVG(cpu) FROM cpu '
```

## Remove Columns

```sh
cut -d',' -f4- ./out/mydata.csv > ./out/mydata_3_less_columns.csv
```

## Resources

- My jq examples [here](../jq/README.md)
- https://til.simonwillison.net/sqlite/one-line-csv-operations
- TidyViewer [here](https://github.com/alexhallam/tv)
