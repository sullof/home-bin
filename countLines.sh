#!/usr/bin/env bash

find $1 -name "*.$2" -exec sed '/^\s*$/d' {} + | wc -l
