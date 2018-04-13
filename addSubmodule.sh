#!/usr/bin/env bash

git submodule add $1
git submodule update --init --recursive
