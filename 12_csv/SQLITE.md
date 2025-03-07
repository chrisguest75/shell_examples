# SQLITE CSV QUERYING

## Logs

```sh
sqlite3 :memory:

.help .mode

export CSV_FILE=''
# import and print out schema (list is | seperator)
sqlite3 :memory: -cmd '.mode list' -cmd ".import ${CSV_FILE} logs -v" 'SELECT * FROM logs LIMIT 10'
# group by
sqlite3 :memory: -cmd '.mode list' -cmd ".import ${CSV_FILE} logs -v" 'SELECT ip, COUNT(ip) FROM logs GROUP BY ip'
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

## Resources

- https://til.simonwillison.net/sqlite/one-line-csv-operations
