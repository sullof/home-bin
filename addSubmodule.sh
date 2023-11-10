#!/usr/bin/env bash

git submodule add $1 $2
git submodule update --init --recursive
