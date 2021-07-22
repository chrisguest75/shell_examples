#!/usr/bin/env bash

echo "from stdout"
# >&2 maps stdout FD to stderr FD
>&2 echo "from stderr"