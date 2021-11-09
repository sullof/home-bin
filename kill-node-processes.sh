#!/usr/bin/env bash

# sometimes Ctr-c is unable to stop the running process. In those
# cases, use Ctrl-z. Some process can remain up and block the listening port.
# To fix it you can run this scripti, which kills all the direct node processes

PS=$(./bin/isListening.sh localhost 6969 | grep node | awk '{print $2}')
kill -9 $PS
