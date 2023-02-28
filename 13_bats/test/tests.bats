#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load 'test_helper/bats-file/load'

load "${BATS_TEST_DIRNAME}/../functions.sh"  

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

# FROM https://github.com/ztombol/bats-assert
# @test 'assert_success() status only' {
#   run bash -c "echo 'Error!'; exit 1"
#   assert_success
# }

# @test 'assert_failure() status only' {
#   run echo 'Success!'
#   assert_failure
# }

# @test 'assert_failure() with expected status' {
#   run bash -c "echo 'Error!'; exit 1"
#   assert_failure 2
# }

# @test 'assert_output()' {
#   run echo 'have'
#   assert_output 'want'
# }

# @test 'assert_output() with pipe' {
#   run echo 'have'
#   echo 'want' | assert_output
# }

# @test 'assert_output() partial matching' {
#   run echo 'ERROR: no such file or directory'
#   assert_output --partial 'SUCCESS'
# }

# @test 'assert_output() regular expression matching' {
#   run echo 'Foobar 0.1.0'
#   assert_output --regexp '^Foobar v[0-9]+\.[0-9]+\.[0-9]$'
# }

# @test 'assert_line() looking for line' {
#   run echo $'have-0\nhave-1\nhave-2'
#   assert_line 'want'
# }

# @test 'assert_line() specific line' {
#   run echo $'have-0\nhave-1\nhave-2'
#   assert_line --index 1 'want-1'
# }

#*******************************************************************
#* add_trailing_slash
#*******************************************************************

@test "check ./README.md file exists " {
    assert_file_exists ./README.md
}

#*******************************************************************
#* add_trailing_slash
#*******************************************************************

@test "add_trailing_slash - No parameter" {
    run add_trailing_slash 
    assert_output --regexp 'add_trailing_slash\(path\) - missing path argument'
    assert_failure
}

@test "add_trailing_slash - Without a trailing slash it should return a trailing slash" {
    run add_trailing_slash 'this/is/my/path'
    assert_output 'this/is/my/path/'
}

@test "add_trailing_slash - With a trailing slash it should not alter the path" {
    run add_trailing_slash 'this/is/my/path/'
    assert_output 'this/is/my/path/'
}

@test "add_trailing_slash - An empty string does not return a root directory" {
    run add_trailing_slash ''
    assert_output ''
}

# #*******************************************************************
# #* trim§
# #*******************************************************************

@test "trim - No parameter" {
    run trim 
    assert_output --regexp 'trim\(string\) - missing string argument'
    assert_failure
}

@test "trim - Empty string is empty string" {
    run trim ''
    assert_output ''  
}

@test "trim - Only whitespace is empty string" {
    run trim '    '
    assert_output ''  
}

@test "trim - No whitespace is same string" {
    run trim 'hello'
    assert_output 'hello'  
}

@test "trim - Beginning whitespace is removed" {
    run trim '    hello'
    assert_output 'hello'  
}

@test "trim - End whitespace is removed" {
    run trim 'hello    '
    assert_output 'hello'    
}

@test "trim - Beginning and end whitespace is removed" {
    run trim '    hello    '
    assert_output 'hello'  
}

@test "trim - All redundant whitespace is removed" {
    run trim '    hello this is    world     '
    assert_output 'hello this is world'
}

