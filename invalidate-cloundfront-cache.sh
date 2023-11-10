#!/usr/bin/env bash

if [ -z "$2" ]
  then
    echo "No distribution id supplied. Example:

    ./invalidate-cloudfront-cache.sh EFSQ4A4BEVTTV "/brucelee-pfp/eth"
"
    exit 1
fi

aws cloudfront create-invalidation --distribution-id $1 --paths "$2/*"
