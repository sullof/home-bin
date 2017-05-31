#!/bin/bash

for var in "$@"
do
    ../sh/deleteLocalBranch.sh $var
done
