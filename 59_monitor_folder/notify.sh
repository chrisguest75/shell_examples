#!/usr/bin/env bash

echo "Monitoring: $1"

ls -la $1

while true; do
    inotifywait -e modify,create,delete,move -r $1 | ./notified.sh
done

