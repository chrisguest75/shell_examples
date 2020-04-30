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

    rm "${BATS_TMPDIR}/bats-mock.$$."* || :
    #ls -l "${BATS_TMPDIR}"/bats-mock* >&3
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

git() { 
    if [[ "$*" == "log --oneline" ]]; then
        ${git_mock} "$@";
    else
        echo "Not recognised";
    fi
    #echo "$@" >&3;    
}
fake_git_log=$(cat <<'EOF'
9ac61e6 (HEAD -> bats-mock, origin/bats-mock) Better library for mocking.
cee3c1d Working out how to get mocks working correctly.
7ebf99f Add a script that needs mocking to test it.
91a5101 Merge pull request #9 from chrisguest75/add_shellcheck_test
6a1d0ff Add shellcheck tests and fix up the script
d406cbc Example of a logger from tfenv
EOF
)

@test "script_to_test - Filtering" {
    #echo "$fake_git_log" >&3 
    git_mock="$(mock_create)"
    mock_set_output "${git_mock}" "$fake_git_log" 
    #echo $git_mock >&3 
    run filter "6a1d0ff" 
    #echo $output >&3 
    assert_output --regexp '^6a1d0ff Add shellcheck tests and fix up the script$'
    assert_equal "$(mock_get_call_num ${git_mock})" 1
    assert_equal "$(mock_get_call_args ${git_mock})" "log --oneline"
    assert_success
}

@test "script_to_test - Multiple lines" {
    #echo "$fake_git_log" >&3 
    git_mock="$(mock_create)"
    mock_set_output "${git_mock}" "$fake_git_log" 
    #echo $git_mock >&3 
    run filter "a"
    #echo $output >&3 
    assert_line --index 0 --regexp '^9ac61e6'
    assert_line --index 1 --regexp '^7ebf99f'
    assert_line --index 2 --regexp '^91a5101'
    assert_line --index 3 --regexp '^6a1d0ff'
    assert_line --index 4 --regexp '^d406cbc'
    assert_equal "$(mock_get_call_num ${git_mock})" 1
    assert_equal "$(mock_get_call_args ${git_mock})" "log --oneline"
    assert_success
}

@test "script_to_test - Filtering everything" {
    #echo "$fake_git_log" >&3 
    git_mock="$(mock_create)"
    mock_set_output "${git_mock}" "$fake_git_log" 
    #echo $git_mock >&3 
    run filter "hello world" 
    #echo $output >&3 
    assert_output ""
    assert_equal "$(mock_get_call_num ${git_mock})" 1
    assert_equal "$(mock_get_call_args ${git_mock})" "log --oneline"
    # grep returns failure if it does not find anything
    assert_failure
}