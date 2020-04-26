#!/usr/bin/env bash 


if ! bats -t ./test/shellcheck.bats; then
    echo "Prerequisites failed"
    exit 1
fi
set -e

bats -t ./test/tests.bats
