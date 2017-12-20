#!/bin/bash

base64 -i $1 -o $1.base64
openssl enc -aes-256-cbc -in $1.base64 -out $1.base64.enc
rm $1.base64
