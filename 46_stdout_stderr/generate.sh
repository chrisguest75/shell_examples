#!/usr/bin/env bash

echo "from stdout"
# shorthand for 1>&2 maps stdout FD to stderr FD - so will echo on stderr
>&2 echo "from stderr"