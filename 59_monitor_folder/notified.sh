#!/usr/bin/env bash

echo "Waiting..."
while read path action file; do
    echo "The file '$file' appeared in directory '$path' via '$action'"
    # do something with the file
done
echo "Exiting"