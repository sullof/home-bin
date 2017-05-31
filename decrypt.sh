#!/bin/bash

if [[ $1 = *".enc" ]]; then
    file=$(sed -e 's/\.enc$//' <<< $1)
else
    file=$1.dec
fi

openssl enc -aes-256-cbc  -d -in $1 -out $file