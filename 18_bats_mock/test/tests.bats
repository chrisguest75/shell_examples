#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load 'test_helper/bats-mock/src/bats-mock'

load "${BATS_TEST_DIRNAME}/../script_to_test.sh"

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
}

teardown() {
    if [[ -n $DEBUG_BATS ]]; then
        echo -e "##### teardown ${BATS_TEST_NAME}\n" >&3 
    fi
}


#*******************************************************************
#* 
#*******************************************************************

@test "script_to_test - No parameter " {
    run ${BATS_TEST_DIRNAME}/../script_to_test.sh 
    #echo $output >&3     
    assert_output --regexp 'Usage: script_to_test\.sh <filter>'
    assert_failure
}

@test "script_to_test - Filter " {
    mock="$(mock_create)"
    mock_set_side_effect "${mock}" "echo 'git output $*'" 
    git() { ${mock} "$@"; }
    #echo $mock >&3 
    run filter "I" 
    echo $output >&3 
    #assert_output --regexp 'Usage: script_to_test\.sh <filter>'
    assert_equal "$(mock_get_call_num ${mock})" 1
    assert_equal "$(mock_get_call_args ${mock})" "log --oneline"
    assert_success
}