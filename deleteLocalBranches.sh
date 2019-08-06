#!/usr/bin/env bash

for var in "$@"
do
    ~/bin/deleteLocalBranch.sh $var
done
