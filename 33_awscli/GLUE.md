# GLUE

Create a database source.  

## Glue

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-1

# create a bucket
aws s3 mb s3://my-athena-data

# create the db
aws glue create-database --database-input '{
    "Name": "athenadata",
    "Description": "mydatabase"
}'

# copy the data
aws s3 cp "files.tsv" s3://my-athena-data/mydata/files.tsv 

# create the table 
aws glue create-table --database-name athenadata --table-input '{
  "Name": "files",
  "StorageDescriptor": {
    "Columns": [
      {"Name": "path", "Type": "string"}
    ],
    "Location": "s3://my-athena-data/mydata",
    "InputFormat": "org.apache.hadoop.mapred.TextInputFormat",
    "OutputFormat": "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
    "SerdeInfo": {
      "SerializationLibrary": "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe",
      "Parameters": {
        "field.delim": "\t",
        "serialization.format": "\t"
      }
    }
  },
  "TableType": "EXTERNAL_TABLE",
  "Parameters": {
    "classification": "csv",
    "delimiter": "\t"
  }
}'
```

## Resources
