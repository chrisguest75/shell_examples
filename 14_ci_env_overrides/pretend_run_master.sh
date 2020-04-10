#!/usr/bin/env bash

CIRCLE_BRANCH=${1-master}
COMMIT_SHA1=${2-fb93e86f557c95d86e5dfc84973661183be8c5fa}

. ./ci_env

function map {
    # find env variables that start with branch and commitid
    while IFS='=' read -r var value 
    do
        local prefix=${CIRCLE_BRANCH}_
        local name="${var/${prefix}/}" 
        export ${name}=${value}
        echo "${var} produces export ${name}=${value}"
    done < <(env | grep ^${CIRCLE_BRANCH})
    while IFS='=' read -r var value 
    do
        local prefix=${COMMIT_SHA1}_
        local name="${var/${prefix}/}" 
        export ${name}=${value}
        echo "${var} produces export ${name}=${value}"
    done < <(env | grep ^${COMMIT_SHA1})
}

map 

echo "******************************************"
echo "FORCE_TEST_FAIL=${FORCE_TEST_FAIL}"
echo "SKIP_TESTS=${SKIP_TESTS}"
echo "DEBUG_TEST_LOGS=${DEBUG_TEST_LOGS}"
echo "TF_LOG=${TF_LOG}"
echo "******************************************"
