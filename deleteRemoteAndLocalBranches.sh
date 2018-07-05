#!/bin/bash

for var in "$@"
do
    deleteRemoteAndLocalBranch.sh $var
done
