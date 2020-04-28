#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load 'test_helper/bats-mock/stub'

load "${BATS_TEST_DIRNAME}/../script_to_test.sh"

function mock_git_log() {
    cat <<- EOF
    usage: $SCRIPT_NAME options

    OPTIONS:
        -a --action              [ps|jobs|ls]
        --debug                  
        -h --help                show this help

    Examples:
        $SCRIPT_NAME --action=ps 

EOF
}
function mock_git_log2() {
    echo $1
}

setup() {
    if [[ -n $DEBUG_BATS ]]; then    
        INDEX=$((${BATS_TEST_NUMBER} - 1))
        echo "##### setup start" >&3 
        echo "BATS_TEST_NAME:        ${BATS_TEST_NAME}" >&3 
        echo "BATS_TEST_FILENAME:    ${BATS_TEST_FILENAME}" >&3 
        echo "BATS_TEST_DIRNAME:     ${BATS_TEST_DIRNAME}" >&3 
        echo "BATS_TEST_NAMES:       ${BATS_TEST_NAMES[$INDEX]}" >&3 
        echo "BATS_TEST_DESCRIPTION: ${BATS_TEST_DESCRIPTION}" >&3 
        echo "BATS_TEST_NUMBER:      ${BATS_TEST_NUMBER}" >&3 
        echo "BATS_TMPDIR:           ${BATS_TMPDIR}" >&3 
        echo "##### setup end" >&3 
    fi
    _GIT_ARGS='log --oneline'
    stub git \
        "${_GIT_ARGS} : mock_git_log" \
        "${_GIT_ARGS} : mock_git_log2 'dssfsafsafas'"

}

teardown() {
    if [[ -n $DEBUG_BATS ]]; then
        echo -e "##### teardown ${BATS_TEST_NAME}\n" >&3 
    fi
    unstub git
}


#*******************************************************************
#* 
#*******************************************************************

@test "script_to_test - No parameter " {
    run ${BATS_TEST_DIRNAME}/../script_to_test.sh 
    echo $output >&3     
    assert_output --regexp 'Usage: script_to_test\.sh <filter>'
    assert_failure
}

@test "script_to_test - Filter " {
    run filter "I" 
    echo $output >&3 
    #assert_output --regexp 'Usage: script_to_test\.sh <filter>'
    assert_success
}