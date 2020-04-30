#!/usr/bin/env bash
set -x
# $@ all parameters 
# $? exit code
# $$ process id

#######################################
# print_first_second
# Arguments:
#   1: Parameter to log out
#   2: Parameter to log out
# Outputs:
#   Writes function name, first and second parameter to stdout
#######################################
function print_first_second() {
    echo "**** $FUNCNAME ****"
    echo "First $1"
    echo "Second $2"
}

#######################################
# print_first
# Arguments:
#   1: Parameter to log out
# Outputs:
#   Writes function name and first parameter to stdout
#######################################
function print_first() {
    echo "**** $FUNCNAME ****"
    echo "First $1"
}

#######################################
# print_all
# Arguments:
#   1+: Parameters to pass to log out
# Outputs:
#   Writes function name and all parameters to stdout
#######################################
function print_all() {
    echo "**** $FUNCNAME ****"
    echo $@
}

#######################################
# pass_through
# Arguments:
#   1:  Function name to invoke
#   2+: Parameters to pass to function 
# Outputs:
#   Writes function name to stdout
#######################################
function pass_through() {
    echo "**** $FUNCNAME ****"
    local func_ptr=$1
    shift
    $func_ptr "$@"
}

print_all "p1 hello" "p2" "p3" "p4"
print_first "p1 hello" "p2" "p3" "p4"
print_first_second "p1 hello" "p2" "p3" "p4"

pass_through "print_all" "p1 hello" "p2" "p3" "p4"
pass_through "print_first" "p1 hello" "p2" "p3" "p4"
pass_through "print_first_second" "p1 hello" "p2" "p3" "p4"
