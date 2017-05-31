#!/usr/bin/env bash

WHO=$(sudo lsof -i :8081)
PREVWORD=
PID=

for word in $WHO; do
    if [[ $PREVWORD = 'node' ]]; then
        PID=$word
    fi
    PREVWORD=$word
done

if [[ ! $PID = "" ]]; then 
    sudo kill -9 $PID
fi

