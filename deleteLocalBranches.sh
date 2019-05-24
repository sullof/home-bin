#!/usr/bin/env bash

for var in "$@"
do
    ../sh/deleteLocalBranch.sh $var
done
