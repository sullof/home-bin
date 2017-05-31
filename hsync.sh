#/bin/bash

if [[ -n $1 ]]; then
  rsync -avz ~/$1/ sullof@h.hooq.co:~/$1/
  rsync -avz ~/$1/ root@hooq.co:~/$1/
fi