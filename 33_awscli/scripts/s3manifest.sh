#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -g --generate              generate manifest file
    -c --check                 check manifest file
    -b=* --bucket=*            source bucket
    -p=* --prefix=*            source prefix
    -m=* --manifest=*          manifest file
    --profile=*                aws profile

Examples:
    $SCRIPT_NAME --help 

EOF
}

# if no variables are passed
#if [ -z "$@" ]; then
#    help
#    exit 0
#fi 

GENERATE=false
CHECK=false
AWS_PROFILE=
BUCKET_SOURCE=
BUCKET_PREFIX=
MANIFEST_FILE=

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    -g|--generate)
        GENERATE=true
        shift
    ;;
    -c|--check)
        CHECK=true
        shift
    ;;
    -b=*|--bucket=*)
        BUCKET_SOURCE="${i#*=}"
        shift # past argument=value
    ;;
    -p=*|--prefix=*)
        BUCKET_PREFIX="${i#*=}"
        shift # past argument=value
    ;;
    -m=*|--manifest=*)
        MANIFEST_FILE="${i#*=}"
        shift # past argument=value
    ;;
    --profile=*)
        AWS_PROFILE="${i#*=}"
        shift # past argument=value
    ;;
esac
done

if [[ "$MANIFEST_FILE" == "" ]]; then
    >&2 echo ""
    >&2 echo "ERROR: --manifest is required"
    >&2 echo ""
    exit 1
fi

if [[ "$GENERATE" == true ]]; then
    if [[ "$BUCKET_SOURCE" == "" ]]; then
        >&2 echo ""
        >&2 echo "ERROR: --bucket is required"
        >&2 echo ""
        exit 1
    fi

    if [[ "$BUCKET_PREFIX" == "" ]]; then
        >&2 echo ""
        >&2 echo "ERROR: --prefix is required"
        >&2 echo ""
        exit 1
    fi

    TMP_FILE=$(mktemp)
    >&2 echo "TMP_FILE=$TMP_FILE"

    aws s3api list-objects --bucket ${BUCKET_SOURCE} --prefix ${BUCKET_PREFIX} --query 'Contents[].{Key: Key}' > ${TMP_FILE} 

    while IFS=, read -r _filename
    do
        aws s3api get-object-attributes --bucket ${BUCKET_SOURCE} --key ${_filename} --object-attributes Checksum ObjectSize ETag --output json | jq -r --arg bucket "${BUCKET_SOURCE}" --arg filename "${_filename}" '{bucket: $bucket, prefix: $filename, md5: .ETag, size: .ObjectSize}'
    done < <(jq -r '.[].Key' ${TMP_FILE}) | jq -s . > ${MANIFEST_FILE}
fi

if [[ "$CHECK" == true ]]; then
    PASS=true

    while IFS=$'\t', read -r _bucket _filename _md5
    do
        set +ef
        #echo "$_bucket $_filename $_md5"
        VALID=$(aws s3api get-object-attributes --bucket $_bucket --key $_filename --object-attributes Checksum ObjectSize ETag --output json  | jq -r --arg md5 "$_md5" --arg filename "${_filename}" ' 
    if .ETag == $md5
    then "valid" 
    else error("invalid") 
    end 
')
        SUCCESS=$? 
        set -ef
        if [[ $SUCCESS -eq 0 ]]; then
            echo "s3://${_bucket}/${_filename} is ${_md5} and valid"
        else
            echo "s3://${_bucket}/${_filename} is ${_md5} and invalid"
            PASS=false
        fi 
            #| jq -r --arg filename "${_filename}" '{prefix: $filename, md5: .ETag}'
    done < <(jq -r '.[] | [.bucket, .prefix, .md5] | @tsv' ${MANIFEST_FILE})

    if [[ "$PASS" == true ]]; then
        echo "PASS"
        exit 0
    else
        echo "FAIL"
        exit 1
    fi
fi
