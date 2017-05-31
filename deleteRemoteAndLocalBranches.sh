#!/bin/bash

for var in "$@"
do
    ../sh/deleteRemoteAndLocalBranch.sh $var
done
