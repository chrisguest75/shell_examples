#!/usr/bin/env bash

echo "Array based multiple return values"
declare -g -a multivalue_array_value
# Return multiple values
function multivalue_array {
    multivalue_array_value[0]=$1
    multivalue_array_value[1]=$2
    multivalue_array_value[2]=$3
}

multivalue_array "value1" "value2" "value3"

echo ${multivalue_array_value[0]}
echo ${multivalue_array_value[1]}
echo ${multivalue_array_value[2]}
echo ""

echo "Associative Array based multiple return values"
declare -g -A multivalue_assocarray_value
# Return multiple values
function multivalue_assocarray {
    multivalue_assocarray_value["first"]=$1
    multivalue_assocarray_value["second"]=$2
    multivalue_assocarray_value["third"]=$3
}

multivalue_assocarray "value1" "value2" "value3"

echo ${multivalue_assocarray_value["first"]}
echo ${multivalue_assocarray_value["second"]}
echo ${multivalue_assocarray_value["third"]}
echo ""

