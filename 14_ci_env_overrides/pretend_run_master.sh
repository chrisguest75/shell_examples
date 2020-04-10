#!/usr/bin/env bash
CIRCLE_BRANCH=master
COMMIT_SHA1=fb93e86f557c95d86e5dfc84973661183be8c5fa

. ./ci_env

function map {
    while read -r var 
    do
        local prefix=${CIRCLE_BRANCH}_
        local name="${${var}/${prefix}/dd}" 
        export ${!name}
    done < <(env | grep ${CIRCLE_BRANCH})
}

map 

echo "FORCE_TEST_FAIL=${FORCE_TEST_FAIL}"
echo "SKIP_TESTS=${SKIP_TESTS}"
echo "DEBUG_TEST_LOGS=${DEBUG_TEST_LOGS}"
echo "TF_LOG=${TF_LOG}"