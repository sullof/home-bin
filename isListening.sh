#!/usr/bin/env bash

echo "Syntax: isListening <host> <port>"

nc -z $1 $2
