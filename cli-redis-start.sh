#!/bin/bash

docker run -it --link sf_redis:redis --rm redis redis-cli -h redis -p 6379
