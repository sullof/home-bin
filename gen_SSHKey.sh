#!/usr/bin/env bash

while getopts "f:e:" opt; do
  case $opt in
    e)
      EMAIL=$OPTARG
      ;;
    f)
      FILENAME=$OPTARG
      ;;
    \?)
      echo "
ERROR: Invalid option.
"
      exit 1
      ;;
  esac
done

if [[ "$FILENAME" != "" ]]; then
	ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/$FILENAME -C "$EMAIL"
else
	ssh-keygen -o -a 100 -t ed25519 -C "$EMAIL"
fi

ssh-keygen -t ed25519 -b 256 -C devtools@tron.network
