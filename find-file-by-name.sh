#!/bin/bash

#find . -path '*/node_modules' -prune -o -type f -name 'Valida*.sol' -print
find . -path '*/node_modules' -prune -o -type f -name '$1' -print
