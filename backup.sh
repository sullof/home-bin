#!/usr/bin/env bash

rsync -avh $1/ $2/ --delete
