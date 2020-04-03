#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

load "${BATS_TEST_DIRNAME}/../functions.sh"  

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

@test "Without a trailing slash it should return a trailing slash" {
    run add_trailing_slash 'this/is/my/path'
    assert_output 'this/is/my/path/'
}

@test "With a trailing slash it should not alter the path" {
    run add_trailing_slash 'this/is/my/path/'
    assert_output 'this/is/my/path/'
}

@test "An empty string does not return a root directory" {
    run add_trailing_slash ''
    assert_output ''
}

# #*******************************************************************
# #* trim§
# #*******************************************************************

@test "Empty string is empty string" {
    run trim ''
    assert_output ''  
}

@test "Only whitespace is empty string" {
    run trim '    '
    assert_output ''  
}

@test "No whitespace is same string" {
    run trim 'hello'
    assert_output 'hello'  
}

@test "Beginning whitespace is removed" {
    run trim '    hello'
    assert_output 'hello'  
}

@test "End whitespace is removed" {
    run trim 'hello    '
    assert_output 'hello'    
}

@test "Beginning and end whitespace is removed" {
    run trim '    hello    '
    assert_output 'hello'  
}

@test "All redundant whitespace is removed" {
    run trim '    hello this is    world     '
    assert_output 'hello this is world'
}

