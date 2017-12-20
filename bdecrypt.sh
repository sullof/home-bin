#!/bin/bash

f=$(sed -e 's/\.base64.enc$//' <<< $1)
openssl enc -aes-256-cbc  -d -in $f.base64.enc -out $f.base64
base64 -D -i $f.base64 -o $f
rm $f.base64
