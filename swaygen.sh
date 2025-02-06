#!/bin/bash

DIRS=$(find ./assists -maxdepth 1 -type d)
for dir in $DIRS; do
    echo "$dir"
    # get list of shell scripts in the directory
    SHELL_SCRIPTS=$(find "$dir" -maxdepth 1 -type f -name "*.sh")
    echo "shell $SHELL_SCRIPTS"
done

# TODO: weiter 


echo "$DIRS"

