#!/bin/bash

git fetch origin pull/$1/head:$2
git checkout $2
