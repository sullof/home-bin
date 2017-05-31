#!/bin/bash

docker run --name sf_redis -v ~/vol/db/redis/shortfestival:/data -d redis:latest redis-server --appendonly yes
