#!/usr/bin/env bash
ip=$(curl -s 'https://api.ipify.org?format=json' | jq --raw-output .ip)
logger "$ip"
echo "$ip"
