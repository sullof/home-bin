#!/bin/bash
pid=$(lsof -i:$1 -t); kill -TERM $pid || kill -KILL $pid
