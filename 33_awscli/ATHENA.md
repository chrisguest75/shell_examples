# ATHENA

REF: [chrisguest75/sql_examples/12_athena/README.md](https://github.com/chrisguest75/sql_examples/blob/main/12_athena/README.md)  

NOTES:

* A SerDe is a serialiser and deserialiser

## Help

```sh
aws --no-cli-pager athena help

export AWS_PROFILE=myprofile
export AWS_REGION=us-east-1
```

### Athena Options

```txt
batch-get-named-query
batch-get-prepared-statement
batch-get-query-execution
cancel-capacity-reservation
create-capacity-reservation
create-data-catalog
create-named-query
create-notebook
create-prepared-statement
create-presigned-notebook-url
create-work-group
delete-capacity-reservation
delete-data-catalog
delete-named-query
delete-notebook
delete-prepared-statement
delete-work-group
export-notebook
get-calculation-execution
get-calculation-execution-code
get-calculation-execution-status
get-capacity-assignment-configuration
get-capacity-reservation
get-data-catalog
get-database
get-named-query
get-notebook-metadata
get-prepared-statement
get-query-execution
get-query-results
get-query-runtime-statistics
get-session
get-session-status
get-table-metadata
get-work-group
import-notebook
list-application-dpu-sizes
list-calculation-executions
list-capacity-reservations
list-data-catalogs
list-databases
list-engine-versions
list-executors
list-named-queries
list-notebook-metadata
list-notebook-sessions
list-prepared-statements
list-query-executions
list-sessions
list-table-metadata
list-tags-for-resource
list-work-groups
put-capacity-assignment-configuration
start-calculation-execution
start-query-execution
start-session
stop-calculation-execution
stop-query-execution
tag-resource
terminate-session
untag-resource
update-capacity-reservation
update-data-catalog
update-named-query
update-notebook
update-notebook-metadata
update-prepared-statement
update-work-group
```

## Environments

```sh
# list the engine versions
aws --no-cli-pager athena list-engine-versions | jq .

# show workgroup details (engine version)
aws --no-cli-pager athena list-work-groups | jq .

# show the capcity reservations 
aws --no-cli-pager athena list-capacity-reservations
```

## Discover

```sh
# list the data-catalogs
aws --no-cli-pager athena list-data-catalogs | jq . 

# list databases within a data catalog
aws --no-cli-pager athena list-databases --catalog-name AwsDataCatalog | jq .

# just gets name and description
aws --no-cli-pager athena get-database --catalog-name AwsDataCatalog --database-name mydatabase | jq .

# this just returns Ids 
aws --no-cli-pager athena list-query-executions | jq .

# get execution details for a query
aws --no-cli-pager athena get-query-execution --query-execution-id $(aws --no-cli-pager athena list-query-executions | jq -r '.QueryExecutionIds[0]') | jq .
```

## Execute

```sh
export ATHENA_S3_PATH='s3://aws-athena-query-results/cli'

read -d '' sqlquery << EOF
SELECT COUNT(1)
FROM request_logs.cloudfront_access_logs WHERE date BETWEEN cast('2022-10-01' as date) AND cast('2022-11-01' as date)
EOF

QUERY_ID=$(aws --no-cli-pager athena start-query-execution --query-string "$sqlquery" --result-configuration "OutputLocation=$ATHENA_S3_PATH" | jq -r '.QueryExecutionId')
echo $QUERY_ID
aws --no-cli-pager athena get-query-execution --query-execution-id "$QUERY_ID"

aws --no-cli-pager athena get-query-results --query-execution-id "$QUERY_ID" | jq . 
```

## Resources

* Athena API Reference [here](https://docs.aws.amazon.com/athena/latest/APIReference/Welcome.html)
* Using AWS Athena from AWS CLI and bash. [here](https://frankcontrepois.com/post/20210211-tech-athenafrombash/)
* Athena engine versioning [here](https://docs.aws.amazon.com/athena/latest/ug/engine-versions.html)  
